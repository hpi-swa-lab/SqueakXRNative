Class {
	#name : #SRSendInputAction,
	#superclass : #SRHandAction,
	#category : #'SqueakXR-Input'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/19/2026 14:24'
}
SRSendInputAction >> analogEventValue: aValue for: anAxis [

	^ SRInputEventAnalog new
		hand: self;
		axis: anAxis;
		value: aValue
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/19/2026 14:12'
}
SRSendInputAction >> buttonEventPressed: aBool for: aButton [

	^ SRInputEventButton new
		hand: self hand;
		button: aButton;
		pressed: aBool
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/19/2026 15:18'
}
SRSendInputAction >> perform: inputState [ 

	"I send any inputs to the first target."
	| events first |
	
	first := self hand cursor firstIntersection ifNil: [ ^ true ].
	events := OrderedCollection new.
	
	"Button events."
	#(#trigger #squeeze #topButton #bottomButton #menuButton) do: [ :button |
		| state |
		state := inputState perform: button.
		state isJustPressed ifTrue: [ events add: (self buttonEventPressed: true for: button) ].
		state isJustReleased ifTrue: [ events add: (self buttonEventPressed: false for: button) ].
	].

	#(#joystick #trigger #squeeze) do: [ :axis | 
		| value |
		value := (inputState perform: axis) value.
		value isZero ifFalse: [ 
			events add: (self analogEventValue: value for: axis)
		].
	].

	events do: [:event |
		event
			target: first object;
			point: first point.
		first object handleInput: event.
	].
	
	^ true
]
