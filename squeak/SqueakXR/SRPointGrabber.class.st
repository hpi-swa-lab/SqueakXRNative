Class {
	#name : #SRPointGrabber,
	#superclass : #SRObject,
	#instVars : [
		'hand',
		'grabbedTransform',
		'cursor',
		'approached',
		'hovered',
		'grabbed',
		'approachColor',
		'hoverColor',
		'grabColor'
	],
	#category : #'SqueakXR-Halo'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 9/8/2026 16:29'
}
SRPointGrabber class >> approachDistance [

	^ 1
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 9/8/2026 16:32'
}
SRPointGrabber class >> hoverDistance [ 

	^ 10cm
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 9/8/2026 16:21'
}
SRPointGrabber >> approachColor [
	^ approachColor
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 9/8/2026 16:21'
}
SRPointGrabber >> approachColor: anObject [
	approachColor := anObject
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 9/8/2026 16:21'
}
SRPointGrabber >> approachColorAt: aDistance [
	"Blend in approach color based on distance"
	| t |
	t := (aDistance / self class approachDistance) clampLow: 0 high: 1.
	^ (Color transparent) alphaMixed: t with: self approachColor
]

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
	#'squeak_changestamp' : 'phkeese 9/8/2026 16:22'
}
SRPointGrabber >> grabColor [
	^ grabColor
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 9/8/2026 16:22'
}
SRPointGrabber >> grabColor: anObject [
	grabColor := anObject
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
	#'squeak_changestamp' : 'phkeese 9/8/2026 16:21'
}
SRPointGrabber >> hoverColor [
	^ hoverColor
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 9/8/2026 16:21'
}
SRPointGrabber >> hoverColor: anObject [
	hoverColor := anObject
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
	#'squeak_changestamp' : 'phkeese 9/8/2026 16:22'
}
SRPointGrabber >> initialize [
	super initialize.
	cursor := SROverlayCube new
		scale: 10cm asVector3;
		wantsHalo: false.
	
	approachColor := Color black.
	hoverColor := Color green.
	grabColor := Color green darker.
	
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
	#'squeak_changestamp' : 'phkeese 9/8/2026 16:30'
}
SRPointGrabber >> renderOverlayOn: aRenderer [
	approached do: [:info | | d target |
		target := info at: 1.
		d := info at: 2.
		target haloSpec renderOn: aRenderer withColor: (self approachColorAt: d).
	].
	
	self grabbed ifNotNil: [:grabbed |
		grabbed haloSpec renderOn: aRenderer withColor: self grabColor.
	] ifNil: [
		self hovered ifNotNil: [:hovered |
			hovered haloSpec renderOn: aRenderer withColor: self hoverColor
		]
	]	
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
	#'squeak_changestamp' : 'phkeese 9/8/2026 16:36'
}
SRPointGrabber >> step: deltaTime [
	self updateHovered.
	self updateGrabbing.
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
	#'squeak_changestamp' : 'phkeese 9/8/2026 16:36'
}
SRPointGrabber >> updateGrabbing [
"	self hovered
		ifNil: [ cursor color: Color black ]
		ifNotNil: [ cursor color: Color red ]."
	self hand squeeze isJustPressed ifTrue: [
		self hovered ifNotNil: [ self startGrabbing: self hovered ]
	].
	(self hand squeeze isJustReleased)
		ifTrue: [ self stopGrabbing ].
]

{
	#category : #stepping,
	#'squeak_changestamp' : 'phkeese 9/8/2026 16:32'
}
SRPointGrabber >> updateHovered [
	| dist here closest |
	approached := OrderedCollection new.
	here := self globalTranslation.
	dist := Float infinity.
	(SRHalo specsIn: self world) do: [:spec |
		spec collision ifNotNil: [:geom | | d |
			d := geom distanceTo: here.
			(d < self class approachDistance) ifTrue: [
				approached add: {spec target. d}.
			].
			((d < self class hoverDistance) and: (d < dist)) ifTrue: [
				dist := d. closest := spec.
			]
		]
	].
	closest 
		ifNil: [ self hovered: nil ]
		ifNotNil: [ self hovered: closest target.	]
	
]
