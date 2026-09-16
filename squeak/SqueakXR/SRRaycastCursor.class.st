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
	#'squeak_changestamp' : 'phkeese 9/16/2026 11:19'
}
SRRaycastCursor class >> laserWidth [
	^ 0.5cm
]

{
	#category : #updating,
	#'squeak_changestamp' : 'phkeese 9/15/2026 17:34'
}
SRRaycastCursor >> castRay [
	"Cast ray into scene but filter out any objects that don't want a cursor"

	| ray targets |
	self world ifNil: [ ^ nil ].
	targets := self targetsIn: self world.
	ray := SRRay origin: self globalTranslation forward: self backward.
	^ (ray castAllObjects: targets) ifEmpty: [ nil ] ifNotEmpty: [ :results | results first ]
]

{
	#category : #initialize,
	#'squeak_changestamp' : 'phkeese 9/16/2026 11:31'
}
SRRaycastCursor >> initialize [ 

	super initialize.
	
	raycube := SRCube new
		color: (Color red alpha: 0.5).
	
	self 
		addChild: (SRCube new scale: 10cm asVector3);
		addChild: raycube.
]

{
	#category : #events,
	#'squeak_changestamp' : 'phkeese 9/16/2026 11:23'
}
SRRaycastCursor >> onActionsUpdated [ 

	self updateHover
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
	#'squeak_changestamp' : 'phkeese 9/16/2026 11:26'
}
SRRaycastCursor >> updateVisuals [

	| length width |
	super updateVisuals.
	width := self class laserWidth.
	length := (self point 
		ifNotNil: [:point | point distanceTo: self globalTranslation ]
		ifNil: [ 10 ]).
	raycube 
		scale: width @ width @ length;
		translation: 0 @ 0 @ (length negated / 2).
]
