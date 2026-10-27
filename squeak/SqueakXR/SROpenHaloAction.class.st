Class {
	#name : #SROpenHaloAction,
	#superclass : #SRGrabAction,
	#instVars : [
		'lastEvent',
		'state',
		'timeout',
		'limboTime',
		'limboTarget'
	],
	#category : #'SqueakXR-Halo'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/26/2026 11:29'
}
SROpenHaloAction class >> findHaloTarget: start [

	| target here |
	here := start.
	target := nil.
	[ here ] whileNotNil: [
		here allowsHalo ifFalse: [^nil].
		here hasHalo ifTrue: [^target].
		here wantsHalo ifTrue: [target := here].
		here := here parent.
	].
	^ target
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/27/2026 11:28'
}
SROpenHaloAction class >> grabAngleThreshold [
	
	^5 "degrees"
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/27/2026 11:30'
}
SROpenHaloAction class >> grabMovementThreshold [
	
	^5cm
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/27/2026 12:11'
}
SROpenHaloAction class >> grabTimeout [ 

	^0.5 "seconds"
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/27/2026 12:45'
}
SROpenHaloAction >> grabLimboTarget [

	| target |
	limboTarget ifNil: [^self].
	self hand haloState closeHalo.
	self state: #grabbing:.
	target := limboTarget grabTarget.
	target grabbingHand ifNotNil: [^self].
	Transcript showln: 'Grabbing ', target.
	self startGrabbing: target.
	self hand cursor progress: 0.


]

{
	#category : #states,
	#'squeak_changestamp' : 'phkeese 10/26/2026 16:43'
}
SROpenHaloAction >> grabbing: inputState [

	inputState bottomButton isJustReleased ifTrue: [
		self state: #idle:.
		self stopGrabbing.
		^ false.
	].
	self dragGrabbedObject.
	^ self isGrabbing not
]

{
	#category : #states,
	#'squeak_changestamp' : 'phkeese 10/27/2026 12:40'
}
SROpenHaloAction >> idle: inputState [

	inputState bottomButton isJustPressed ifFalse: [
		"We only care about halos."
		^ true
	] ifTrue: [
		limboTime := Time now.
		limboTarget := self hand cursorTarget.
		limboTarget ifNotNil: [self prepareGrab: limboTarget grabTarget].
		self state: #limbo:.
		^ false
	]
	
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/26/2026 16:06'
}
SROpenHaloAction >> initialize [ 

	lastEvent := Sensor eventTimeNow.
	state := #idle:.
]

{
	#category : #states,
	#'squeak_changestamp' : 'phkeese 10/27/2026 12:44'
}
SROpenHaloAction >> limbo: inputState [ 

	inputState bottomButton isJustReleased ifTrue: [
		self state: #idle:.
		self hand cursor progress: 0.
		^self openHalo
	].

	self shouldGrab ifTrue: [ self grabLimboTarget. ^false ].
	self hand cursor progress: (self timeInLimbo / self class grabTimeout).

	^true
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/27/2026 12:39'
}
SROpenHaloAction >> openHalo [
	
	| target |
	target := self class findHaloTarget: limboTarget.
	target
		ifNil: [ self hand haloState closeHalo ]
		ifNotNil: [ 
			Transcript showln: 'Opening halo on ', (target ancestorChain collect: [:node | node name]) reverse.
			target addHalo: (SRInputEventButton new
			target: target;
			point: self hand cursorPoint;
			hand: self hand;
			button: #bottomButton;
			pressed: true
		)
	].
	
	^ false	
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/26/2026 16:06'
}
SROpenHaloAction >> run: inputState [ 

	^self perform: state with: inputState
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/27/2026 11:55'
}
SROpenHaloAction >> shouldGrab [

	^self timeInLimbo >= self class grabTimeout
	"handXform := self hand globalTransform.
	(limboXform translation distanceTo: handXform translation) > self class grabMovementThreshold ifTrue: [^true].
	angleDiff := (handXform rotationQuaternion inverse * limboXform rotationQuaternion) angle.
	(self class grabAngleThreshold <= angleDiff abs) ifTrue: [^true]."
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/26/2026 16:32'
}
SROpenHaloAction >> state: aSelector [

	Transcript showln: 'New state: ', state, ' -> ', aSelector.
	state := aSelector.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/27/2026 12:10'
}
SROpenHaloAction >> timeInLimbo [

	^(limboTime to: Time now) duration asMilliSeconds / 1000
]
