Class {
	#name : #SROpenHaloAction,
	#superclass : #SRHandAction,
	#instVars : [
		'lastEvent'
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
	#'squeak_changestamp' : 'phkeese 10/19/2026 16:43'
}
SROpenHaloAction >> initialize [ 

	lastEvent := Sensor eventTimeNow.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/26/2026 11:42'
}
SROpenHaloAction >> perform: inputState [ 

	| start target |
	inputState bottomButton isJustPressed ifFalse: [
		"We only care about halos."
		^ true
	].

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
