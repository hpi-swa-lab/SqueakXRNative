Class {
	#name : #SRRaycastCursor,
	#superclass : #SRCursor,
	#instVars : [
		'rayhit',
		'raycube'
	],
	#category : #'SqueakXR-Input'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 9/15/2026 17:19'
}
SRRaycastCursor >> castRay [
	
	"Cast ray into scene but filter out any objects that don't want a cursor"
	| ray targets |
	self world ifNil: [ ^ nil ].
	targets := self world allDescendantsSelect: [:object | object wantsCursor ].
	ray := SRRay
		origin: self globalTranslation
		forward: self backward.
	^ (ray castAllObjects: targets)
		ifEmpty: [ nil ]
		ifNotEmpty: [: results | results first ]
]

{
	#category : #initialize,
	#'squeak_changestamp' : 'phkeese 9/15/2026 16:57'
}
SRRaycastCursor >> initialize [ 

	super initialize.
	
	raycube := (SRCube new
		scale: 1cm @ 1cm @ 10m
	).
	
	self 
		addChild: (SRCube new scale: 10cm asVector3);
		addChild: raycube.
]

{
	#category : #updating,
	#'squeak_changestamp' : 'phkeese 9/15/2026 16:58'
}
SRRaycastCursor >> onActionsUpdated [ 

	self 
		updateHover;
		updateLaser
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
	#'squeak_changestamp' : 'phkeese 9/15/2026 17:19'
}
SRRaycastCursor >> updateHover [

	| newHit newTarget oldTarget |
	newHit := self castRay.
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

{
	#category : #updating,
	#'squeak_changestamp' : 'phkeese 9/15/2026 17:06'
}
SRRaycastCursor >> updateLaser [

	| length |
	length := (self point 
		ifNotNil: [:point | point distanceTo: self globalTranslation ]
		ifNil: [ 10 ]).
	raycube 
		scale: 1cm @ 1cm @ length;
		translation: 0 @ 0 @ (length negated / 2).
]
