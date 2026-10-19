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
	#'squeak_changestamp' : 'phkeese 10/19/2026 16:43'
}
SROpenHaloAction >> initialize [ 

	lastEvent := Sensor eventTimeNow.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/19/2026 16:46'
}
SROpenHaloAction >> perform: inputState [ 

	| sinceLast |
	inputState bottomButton isJustPressed ifFalse: [
		"We only care about halos."
		^ true
	].

	"TODO: Find out why we are performed so fast again, but debounce for now."
	sinceLast := Sensor eventTimeNow - lastEvent.
	(sinceLast) < 100 ifTrue: [ ^ true ].
	lastEvent := Sensor eventTimeNow.

	self hand cursorTarget 
		ifNil: [ self hand haloState closeHalo ]
		ifNotNil: [:target | | event |
			event := (SRInputEventButton new
				target: target;
				point: self hand cursorPoint;
				hand: self hand;
				button: #bottomButton;
				pressed: true
			).
			Transcript showln: 'Opening Halo on ', target.
			target addHalo: event
		].
	
	^ false
]
