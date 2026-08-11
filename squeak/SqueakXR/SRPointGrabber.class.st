Class {
	#name : #SRPointGrabber,
	#superclass : #SRObject,
	#instVars : [
		'hand',
		'grabbedObject',
		'grabbedTransform'
	],
	#category : #'SqueakXR-Halo'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 8/10/2026 16:58'
}
SRPointGrabber >> color: aColor [
	self childrenDo: [:c | c color: aColor]
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
	#category : #initialization,
	#'squeak_changestamp' : 'phkeese 8/11/2026 11:58'
}
SRPointGrabber >> initialize [
	super initialize.
	self addChild: (SRCube new
		scale: 10cm asVector3;
		color: (1@0@0@0.5)).
]

{
	#category : #stepping,
	#'squeak_changestamp' : 'phkeese 8/11/2026 11:20'
}
SRPointGrabber >> startGrabbing: anSRObject [
	Transcript showln: 'Start grabbing ', anSRObject.
	grabbedObject := anSRObject.
	grabbedTransform := self globalTransform inverseTransformation * grabbedObject globalTransform.
]

{
	#category : #stepping,
	#'squeak_changestamp' : 'phkeese 8/11/2026 11:31'
}
SRPointGrabber >> step: deltaTime [
	self updateGrabbing.
	self hand squeeze isJustPressed
	ifTrue: [ 'Just squeezed!' ].
	grabbedObject ifNotNil: [ grabbedObject globalTransform: self globalTransform * grabbedTransform ]
]

{
	#category : #stepping,
	#'squeak_changestamp' : 'phkeese 8/11/2026 11:31'
}
SRPointGrabber >> stopGrabbing [
	grabbedObject ifNotNil: [
		Transcript showln: 'Stop grabbing'.
		grabbedObject := nil.
		grabbedTransform := nil.
	]
]

{
	#category : #stepping,
	#'squeak_changestamp' : 'phkeese 8/11/2026 14:38'
}
SRPointGrabber >> updateGrabbing [
	| collisions |
	collisions := SRCollisionPoint new
		origin: self globalTranslation;
		radius: 5cm;
		cast: self world.
	(collisions notEmpty and: [ self hand squeeze isJustPressed ])
		ifTrue: [ self startGrabbing: collisions first ].
	
	(self hand squeeze isJustReleased)
		ifTrue: [ self stopGrabbing ].
]
