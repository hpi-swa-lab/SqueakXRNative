Class {
	#name : #SRSendInputAction,
	#superclass : #SRHandAction,
	#instVars : [
		'lastTarget',
		'lastPoint'
	],
	#category : #'SqueakXR-Halo'
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
	#category : #private,
	#'squeak_changestamp' : 'MCPServer (jl) 11/18/2026 18:51'
}
SRSendInputAction >> dismissPopUpMenusFor: target [
	"Deferred, so it runs before the click the panel defers after it."
	| morphicWorld clicked |
	morphicWorld := self hand world ifNotNil: [:world | world morphicWorld].
	(morphicWorld respondsTo: #dismissPopUpMenusExcept:) ifFalse: [^ self].
	clicked := target ifNotNil: [
		(target ancestorChain
			detect: [:each | each isMorphPanel]
			ifNone: [nil]) ifNotNil: [:panel | panel morph]].
	Project current addDeferredUIMessage: [
		morphicWorld dismissPopUpMenusExcept: clicked]
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MCPServer (jl) 11/18/2026 18:51'
}
SRSendInputAction >> run: inputState [ 

	"I send any inputs to the first target."
	| events point target |
	
	target := self hand cursorTarget.
	point := self hand cursorPoint.
	
	self sendEnterEventsTo: target at: point.
	inputState trigger isJustPressed ifTrue: [self dismissPopUpMenusFor: target].
	target ifNil: [ ^ true ].
	
	events := OrderedCollection new.
	events add: (SRInputEventCursorMove new
		target: target;
		point: point;
		hand: self hand
	).
	
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

	inputState wheel isZero ifFalse: [
		events add: (self analogEventValue: inputState wheel for: #wheel)].
	
	events do: [:event |
		event
			target: target;
			point: point.
		target handleInput: event.
	].
	
	^ true
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/20/2026 11:01'
}
SRSendInputAction >> sendEnterEventsTo: target at: point [

	(target = lastTarget) ifTrue: [ ^ self ].
	
	lastTarget ifNotNil: [
		lastTarget handleInput: (SRInputEventCursorLeave new
			target: lastTarget;
			point: lastPoint;
			hand: self hand)].
	lastTarget := target.
	lastPoint := point.
	lastTarget ifNotNil: [
		lastTarget handleInput: (SRInputEventCursorEnter new
			target: lastTarget;
			point: lastPoint;
			hand: self hand)].
]
