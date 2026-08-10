Class {
	#name : #SRPointGrabber,
	#superclass : #SRObject,
	#instVars : [
		'hand'
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
	#'squeak_changestamp' : 'phkeese 8/10/2026 16:58'
}
SRPointGrabber >> initialize [
	super initialize.
	self addChild: (SRCube new
		scale: 1cm asVector3 ).
]

{
	#category : #stepping,
	#'squeak_changestamp' : 'phkeese 8/10/2026 17:34'
}
SRPointGrabber >> step: deltaTime [
	| collisions |
	collisions := SRCollisionPoint new
		origin: self globalTranslation;
		cast: self world.
	collisions isEmpty ifFalse: [
		Transcript showln: 'Intersecting with ', collisions first
	]
]
