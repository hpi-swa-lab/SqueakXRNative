Class {
	#name : #SRCollisionRing,
	#superclass : #SRCollisionGeometry,
	#instVars : [
		'point',
		'normal',
		'innerR',
		'width'
	],
	#category : #'SqueakXR-Collisions'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 11/6/2026 14:22'
}
SRCollisionRing >> drawGizmoOn: aGizmoPainter colored: aColor [
	
	aGizmoPainter gizmoWireCircleAt: self point axis: self normal radius: self innerR color: aColor.
	aGizmoPainter gizmoWireCircleAt: self point axis: self normal radius: self outerR color: aColor.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 11/6/2026 14:11'
}
SRCollisionRing >> innerR [
	^ innerR
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 11/6/2026 14:14'
}
SRCollisionRing >> innerR: aPositiveNumber [
	innerR := aPositiveNumber max: 0
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 11/6/2026 14:11'
}
SRCollisionRing >> normal [
	^ normal
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 11/6/2026 14:12'
}
SRCollisionRing >> normal: aVector3 [
	normal := aVector3
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 11/6/2026 14:14'
}
SRCollisionRing >> outerR [
	^self innerR + self width
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 11/6/2026 14:14'
}
SRCollisionRing >> outerR: aPositiveNumber [
	self width: aPositiveNumber - self innerR
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 11/6/2026 14:11'
}
SRCollisionRing >> point [
	^ point
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 11/6/2026 14:12'
}
SRCollisionRing >> point: aVector3 [
	point := aVector3
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 11/5/2026 17:18'
}
SRCollisionRing >> pointIntersection: aPoint [

	^nil
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 11/6/2026 14:14'
}
SRCollisionRing >> rayIntersection: aRay [

	| denom delta t intersection fromCenter |
	denom := self normal dot: aRay forward.
	denom abs < 1e-6 ifTrue: [^ nil].
	
	delta := self point - aRay origin.
	t := (delta dot: self normal / denom).
	t >= 0 ifFalse: [^ nil].
	
	intersection := aRay project: t.
	fromCenter := self point distanceTo: intersection.
	(fromCenter < self innerR or: [fromCenter > self outerR]) ifTrue: [^nil].
	^ SRIntersectionResult new
		object: self object;
		point: intersection;
		distance: t
		
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 11/6/2026 14:11'
}
SRCollisionRing >> width [
	^ width
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 11/6/2026 14:12'
}
SRCollisionRing >> width: aPositiveNumber [
	
	width := aPositiveNumber max: 0
]
