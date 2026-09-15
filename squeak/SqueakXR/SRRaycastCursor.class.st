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
	#'squeak_changestamp' : 'phkeese 9/15/2026 15:34'
}
SRRaycastCursor >> onActionsUpdated [ 

	self updateHover
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 9/15/2026 16:32'
}
SRRaycastCursor >> onAnalogInput: anAnalogEvent [
	
	anAnalogEvent handled ifTrue: [ ^ self ].
	self targetDo: [:target | 
		anAnalogEvent setFrom: self.
		target handleInput: anAnalogEvent
	]
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 9/15/2026 16:32'
}
SRRaycastCursor >> onButtonInput: aButtonEvent [

	aButtonEvent handled ifTrue: [ ^ self ].
	self targetDo: [:target | 
		aButtonEvent setFrom: self.
		target handleInput: aButtonEvent
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
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 9/14/2026 19:40'
}
SRRaycastCursor >> target [

	^ rayhit ifNotNil: [ rayhit object ]
]

{
	#category : #updating,
	#'squeak_changestamp' : 'phkeese 9/15/2026 16:32'
}
SRRaycastCursor >> updateHover [

	| newHit newTarget oldTarget |
	newHit := self castRayBackward.
	oldTarget := self target.
	newTarget := newHit ifNotNil: [ newHit object ].

	(oldTarget ~= newTarget) ifTrue: [
		self targetDo: [:target | target handleInput: (SRInputEventCursorLeave new setFrom: self)].
	].
	
	rayhit := newHit.
	
	(oldTarget ~= newTarget) ifTrue: [
		self targetDo: [:target | target handleInput: (SRInputEventCursorEnter new setFrom: self)].
	].

	self targetDo: [:target | target handleInput: (SRInputEventCursorMove new setFrom: self)].

]
