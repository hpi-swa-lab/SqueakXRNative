Class {
	#name : #SRRaycastCursor,
	#superclass : #SRCursor,
	#instVars : [
		'rayhit'
	],
	#category : #'SqueakXR-Input'
}

{
	#category : #initialize,
	#'squeak_changestamp' : 'phkeese 9/14/2026 16:02'
}
SRRaycastCursor >> initialize [ 

	super initialize.
	self 
		addChild: (SRCube new scale: 10cm asVector3);
		addChild: (SRCube new
			scale: 1cm @ 1cm @ 10m;
			translation: 0 @ 0 @ -5m).
]

{
	#category : #updating,
	#'squeak_changestamp' : 'phkeese 9/14/2026 20:38'
}
SRRaycastCursor >> onInputsChanged: anInputState [

	self updateHover.
	
	#(#trigger #squeeze #topButton #bottomButton #menuButton) do: [ :button | 
		| state |
		state := anInputState perform: button.
		state isJustPressed ifTrue: [ self sendButtonValue: true for: button ].
		state isJustReleased ifTrue: [ self sendButtonValue: false for: button ].
	].
	#(#joystick #trigger #squeeze) do: [ :axis | 
		| value |
		value := (anInputState perform: axis) value.
		self sendAnalogValue: value for: axis 
	]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 9/14/2026 19:40'
}
SRRaycastCursor >> point [

	^ rayhit ifNotNil: [ rayhit point ]
]

{
	#category : #events,
	#'squeak_changestamp' : 'phkeese 9/14/2026 20:01'
}
SRRaycastCursor >> sendAnalogValue: aValue for: anAxis [

	self targetDo: [:target |
		aValue isZero ifFalse: [
			target onInput: (SRInputEventAnalog new setFrom: self;
				axis: anAxis;
				value: aValue
			)
		]
	]
]

{
	#category : #events,
	#'squeak_changestamp' : 'phkeese 9/14/2026 20:38'
}
SRRaycastCursor >> sendButtonValue: aBool for: aButton [

	self targetDo: [:target |
		target onInput: (SRInputEventButton new setFrom: self;
			button: aButton;
			pressed: aBool
		)
	]

]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 9/14/2026 19:40'
}
SRRaycastCursor >> target [

	^ rayhit ifNotNil: [ rayhit object ]
]

{
	#category : #updating,
	#'squeak_changestamp' : 'phkeese 9/14/2026 20:31'
}
SRRaycastCursor >> updateHover [

	| newHit newTarget oldTarget |
	newHit := self castRayBackward.
	oldTarget := self target.
	newTarget := newHit ifNotNil: [ newHit object ].

	(oldTarget ~= newTarget) ifTrue: [
		self targetDo: [:target | target onInput: (SRInputEventCursorLeave new setFrom: self)].
	].
	
	rayhit := newHit.
	
	(oldTarget ~= newTarget) ifTrue: [
		self targetDo: [:target | target onInput: (SRInputEventCursorEnter new setFrom: self)].
	].

	"self targetDo: [:target | target onInput: (SRInputEventCursorMove new setFrom: self)]."

]
