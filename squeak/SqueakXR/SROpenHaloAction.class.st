Class {
	#name : #SROpenHaloAction,
	#superclass : #SRGrabAction,
	#instVars : [
		'state',
		'limboTarget',
		'grabTarget',
		'limboTime'
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
	#'squeak_changestamp' : 'SqueakXR 10/28/2026 14:59'
}
SROpenHaloAction class >> limboTimeout [ 

	^0.2 "seconds"
]

{
	#category : #states,
	#'squeak_changestamp' : 'phkeese 10/27/2026 14:29'
}
SROpenHaloAction >> closingState: inputState [ 

	inputState bottomButton isJustReleased ifTrue: [
		self hand haloState closeHalo.
		state := #idleState:.
	].
	^false
]

{
	#category : #states,
	#'squeak_changestamp' : 'phkeese 10/27/2026 14:32'
}
SROpenHaloAction >> grabProgress [ 

	^self timeInLimbo / self class limboTimeout
]

{
	#category : #states,
	#'squeak_changestamp' : 'phkeese 10/27/2026 14:54'
}
SROpenHaloAction >> grabbingState: inputState [ 

	inputState bottomButton isJustReleased ifTrue: [
		self stopGrabbing.
		self hand cursor progress: 0.
		state := #idleState:.
		^false
	].
	self hand cursor progress: 1.
	self dragGrabbedObject.
	^false
]

{
	#category : #states,
	#'squeak_changestamp' : 'phkeese 10/27/2026 14:45'
}
SROpenHaloAction >> idleState: inputState [ 

	inputState bottomButton isJustPressed ifFalse: [^true].
	limboTarget := self hand cursorTarget.
	limboTarget ifNil: [
		state := #closingState:.
		^false
	].
	limboTime := Time now.
	grabTarget := limboTarget grabTarget.
	grabTarget grabbingHand 
		ifNil: [
			self prepareGrab: grabTarget.
			state := #limboState:.
		] ifNotNil: [
			state := #openingState:.
		].
	^false
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/27/2026 14:19'
}
SROpenHaloAction >> initialize [ 

	super initialize.
	state := #idleState:.
]

{
	#category : #states,
	#'squeak_changestamp' : 'phkeese 10/27/2026 14:55'
}
SROpenHaloAction >> limboState: inputState [ 

	inputState bottomButton isJustReleased ifTrue: [
		self openHalo.
		self hand cursor progress: 0.
		state := #idleState:.
		^false
	].
	
	self shouldGrab ifTrue: [
		grabTarget ifNotNil: [ self startGrabbing: grabTarget ].
		state := #grabbingState:.
		^false.
	].

	"No transitions, update progress!"
	self hand cursor progress: self grabProgress.

	^false


]

{
	#category : #states,
	#'squeak_changestamp' : 'phkeese 10/27/2026 14:42'
}
SROpenHaloAction >> openHalo [ 

	| target |
	target := self class findHaloTarget: limboTarget.
	target ifNotNil: [ 
			Transcript showln: 'Opening halo on ', (target ancestorChain collect: [:node | node name]) reverse.
			target addHalo: (SRInputEventButton new
			target: target;
			point: self hand cursorPoint;
			hand: self hand;
			button: #bottomButton;
			pressed: true
		)
	] ifNil: [ self hand haloState closeHalo ].
	
	^ false	
]

{
	#category : #states,
	#'squeak_changestamp' : 'phkeese 10/27/2026 14:46'
}
SROpenHaloAction >> openingState: inputState [ 

	inputState bottomButton isJustReleased ifFalse: [^false].
	self shouldGrab ifFalse: [self openHalo].
	state := #idleState:.
	^false
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
	#'squeak_changestamp' : 'phkeese 10/27/2026 14:30'
}
SROpenHaloAction >> shouldGrab [ 

	^self timeInLimbo >= self class limboTimeout
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/27/2026 14:32'
}
SROpenHaloAction >> timeInLimbo [ 

	^(limboTime to: Time now) duration asMilliSeconds / 1000
]
