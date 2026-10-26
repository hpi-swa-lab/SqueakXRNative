Class {
	#name : #SROpenHaloAction,
	#superclass : #SRGrabAction,
	#instVars : [
		'lastEvent',
		'state',
		'timeout',
		'grabTarget',
		'limboXform'
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
	#'squeak_changestamp' : 'phkeese 10/26/2026 17:03'
}
SROpenHaloAction class >> grabAngleThreshold [
	
	^10
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/26/2026 16:59'
}
SROpenHaloAction class >> grabMovementThreshold [
	
	^5cm
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/26/2026 17:03'
}
SROpenHaloAction class >> grabTimeout [ 

	^2
]

{
	#category : #'as yet unclassified',
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
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/26/2026 16:52'
}
SROpenHaloAction >> idle: inputState [

	inputState bottomButton isJustPressed ifFalse: [
		"We only care about halos."
		^ true
	] ifTrue: [
		timeout := Time now addSeconds: self class grabTimeout.
		grabTarget := self hand cursorTarget ifNotNil: [:tgt | tgt grabTarget ].
		self prepareGrab: grabTarget.
		limboXform := self hand globalTransform.
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
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/26/2026 16:54'
}
SROpenHaloAction >> limbo: inputState [ 

	inputState bottomButton isJustReleased ifTrue: [
		self state: #idle:.
		^self openHalo
	].

	self shouldGrab ifTrue: [
		self state: #grabbing:.
		Transcript showln: 'Grabbing ', grabTarget.
		self startGrabbing: grabTarget.
		^false
	].

	^true
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/26/2026 16:14'
}
SROpenHaloAction >> openHalo [
	
	| start target |
	start := self hand cursorTarget.
	target := self class findHaloTarget: start.
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
	#'squeak_changestamp' : 'phkeese 10/26/2026 17:02'
}
SROpenHaloAction >> shouldGrab [

	| handXform |
	(timeout <= Time now) ifTrue: [^true].
	handXform := self hand globalTransform.
	"(limboXform translation distanceTo: handXform translation) > self class grabMovementThreshold ifTrue: [^true]."
	((limboXform localPointToGlobal: Vector3 right) angleTo: (handXform localPointToGlobal: Vector3 right)) > self class grabAngleThreshold degreesToRadians ifTrue: [^true].
	^false
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/26/2026 16:32'
}
SROpenHaloAction >> state: aSelector [

	Transcript showln: 'New state: ', state, ' -> ', aSelector.
	state := aSelector.
]
