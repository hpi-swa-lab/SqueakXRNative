Class {
	#name : #SRCollisionTorus,
	#superclass : #SRCollisionGeometry,
	#instVars : [
		'major',
		'minor',
		'center',
		'axis'
	],
	#category : #'SqueakXR-Collisions'
}

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 11/5/2026 16:59'
}
SRCollisionTorus >> axis [
	^ axis
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 11/5/2026 16:59'
}
SRCollisionTorus >> axis: aVector3 [
	axis := aVector3
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 11/5/2026 16:14'
}
SRCollisionTorus >> center [
	^ center
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 11/5/2026 16:14'
}
SRCollisionTorus >> center: anObject [
	center := anObject
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 11/5/2026 16:17'
}
SRCollisionTorus >> drawGizmoOn: aGizmoPainter colored: aColor [
	
	aGizmoPainter gizmoWireTorus: self color: aColor
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 11/5/2026 16:17'
}
SRCollisionTorus >> major [
	^ major
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 11/5/2026 16:17'
}
SRCollisionTorus >> major: anObject [
	major := anObject
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 11/5/2026 16:17'
}
SRCollisionTorus >> minor [
	^ minor
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 11/5/2026 16:17'
}
SRCollisionTorus >> minor: anObject [
	minor := anObject
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 11/5/2026 17:18'
}
SRCollisionTorus >> pointIntersection: aPoint [

	^nil
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 11/5/2026 17:35'
}
SRCollisionTorus >> rayIntersection: aRay [

	| denom delta t intersection fromCenter |
	denom := self axis dot: aRay forward.
	denom abs < 1e-6 ifTrue: [^ nil].
	
	delta := self center - aRay origin.
	t := (delta dot: self axis / denom).
	t >= 0 ifFalse: [^ nil].
	
	intersection := aRay project: t.
	fromCenter := self center distanceTo: intersection.
	(fromCenter - self major) abs > self minor ifTrue: [^nil].
	^ SRIntersectionResult new
		object: self object;
		point: intersection;
		distance: t
		
]
