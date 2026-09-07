Class {
	#name : #SRPointGrabber,
	#superclass : #SRObject,
	#instVars : [
		'hand',
		'grabbedTransform',
		'cursor',
		'hovered',
		'grabbed'
	],
	#category : #'SqueakXR-Halo'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 8/20/2026 17:43'
}
SRPointGrabber >> findRootFor: aSpec [
	"Hovering just the closest collider may be too specific, so we walk up the tree to select the uppermost object not yet selected."
	| rootSpec |
	Transcript showln: 'Finding root for ', aSpec target.
	rootSpec := aSpec.
	[ rootSpec target isWorldObject not and: (rootSpec target ~= self hovered)] whileTrue: [ | nextUp |
		nextUp := rootSpec target parent haloSpec.
		nextUp ifNil: [ ^ rootSpec ].
		rootSpec := nextUp.
	].
	^rootSpec
	
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 9/7/2026 16:12'
}
SRPointGrabber >> grabbed [
	^ grabbed
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 8/10/2026 17:00'
}
SRPointGrabber >> hand [
	^ hand
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 8/10/2026 17:00'
}
SRPointGrabber >> hand: anObject [
	hand := anObject
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 8/20/2026 17:01'
}
SRPointGrabber >> hovered [
	^ hovered
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 8/20/2026 17:01'
}
SRPointGrabber >> hovered: anObject [
	hovered := anObject
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'phkeese 9/7/2026 16:10'
}
SRPointGrabber >> initialize [
	super initialize.
	cursor := SROverlayCube new
		scale: 10cm asVector3;
		wantsHalo: false.
	self addChild: cursor.
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'phkeese 9/7/2026 16:07'
}
SRPointGrabber >> renderOn: aRenderer [
	
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'phkeese 9/7/2026 16:13'
}
SRPointGrabber >> renderOverlayOn: aRenderer [
	self hovered ifNotNil: [:target |
		target haloSpec renderOn: aRenderer
	].
	self grabbed ifNotNil: [:target |
		target haloSpec renderOn: aRenderer
	].
]

{
	#category : #stepping,
	#'squeak_changestamp' : 'phkeese 9/7/2026 16:12'
}
SRPointGrabber >> startGrabbing: anSRObject [
	Transcript showln: 'Start grabbing ', anSRObject.
	grabbed := anSRObject.
	grabbedTransform := self globalTransform inverseTransformation * grabbed globalTransform.
]

{
	#category : #stepping,
	#'squeak_changestamp' : 'phkeese 9/7/2026 16:12'
}
SRPointGrabber >> step: deltaTime [
	self updateHovered.
	self updateGrabbing.
	self hand squeeze isJustPressed
	ifTrue: [ 'Just squeezed!' ].
	grabbed ifNotNil: [ grabbed globalTransform: self globalTransform * grabbedTransform ]
]

{
	#category : #stepping,
	#'squeak_changestamp' : 'phkeese 9/7/2026 16:12'
}
SRPointGrabber >> stopGrabbing [
	grabbed ifNotNil: [
		Transcript showln: 'Stop grabbing'.
		grabbed := nil.
		grabbedTransform := nil.
	]
]

{
	#category : #stepping,
	#'squeak_changestamp' : 'phkeese 8/20/2026 17:22'
}
SRPointGrabber >> updateGrabbing [
	self hovered
		ifNil: [ cursor color: Color black ]
		ifNotNil: [ cursor color: Color red ].
	self hand squeeze isJustPressed ifTrue: [
		self hovered ifNotNil: [ self startGrabbing: self hovered ]
	].
	(self hand squeeze isJustReleased)
		ifTrue: [ self stopGrabbing ].
]

{
	#category : #stepping,
	#'squeak_changestamp' : 'phkeese 9/7/2026 15:00'
}
SRPointGrabber >> updateHovered [
	| dist here closest |
	here := self globalTranslation.
	dist := Float infinity.
	(SRHalo specsIn: self world) do: [:spec |
		spec collision ifNotNil: [:geom | | d |
			d := geom distanceTo: here.
			((d < 5cm) and: (d < dist)) ifTrue: [ dist := d. closest := spec.]
		]
	].
	closest 
		ifNil: [ self hovered: nil ]
		ifNotNil: [ self hovered: closest target.	]
	
]
