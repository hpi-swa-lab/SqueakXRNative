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
	#category : #constants,
	#'squeak_changestamp' : 'phkeese-MCPServer 11/26/2026 16:46'
}
SRCollisionRing class >> refinementSteps [

	^ 24
]

{
	#category : #constants,
	#'squeak_changestamp' : 'phkeese-MCPServer 11/25/2026 16:30'
}
SRCollisionRing class >> searchSamples [

	^ 32
]

{
	#category : #'collisions - private',
	#'squeak_changestamp' : 'phkeese-MCPServer 11/25/2026 16:30'
}
SRCollisionRing >> anyRadialDirection [

	| candidate |
	candidate := self normal cross: Vector3 right.
	candidate isZero ifTrue: [candidate := self normal cross: Vector3 up].
	^ candidate normalized
]

{
	#category : #collisions,
	#'squeak_changestamp' : 'phkeese-MCPServer 11/25/2026 16:30'
}
SRCollisionRing >> closestPointTo: aPoint [

	| offset radius |
	offset := (aPoint onPlanePoint: self point normal: self normal) - self point.
	radius := offset length.
	radius = 0 ifTrue: [^ self point + (self anyRadialDirection * self innerR)].
	^ self point + (offset * (((radius max: self innerR) min: self outerR) / radius))
]

{
	#category : #'collisions - private',
	#'squeak_changestamp' : 'phkeese-MCPServer 11/25/2026 16:30'
}
SRCollisionRing >> closestPointToMissedRay: aRay [

	^ self closestPointTo: (aRay project: (self parameterClosestTo: aRay))
]

{
	#category : #'collisions - private',
	#'squeak_changestamp' : 'phkeese-MCPServer 11/25/2026 16:30'
}
SRCollisionRing >> distanceFrom: aRay at: aParameter [

	| point |
	point := aRay project: aParameter.
	^ point distanceTo: (self closestPointTo: point)
]

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
	#category : #'collisions - private',
	#'squeak_changestamp' : 'phkeese-MCPServer 11/25/2026 16:30'
}
SRCollisionRing >> parameterClosestTo: aRay [

	| nearest reach low step best |
	nearest := ((self point - aRay origin) dot: aRay forward) max: 0.
	reach := 2 * (self outerR * ((aRay distanceTo: self point) + self outerR)) sqrt.
	low := nearest - reach max: 0.
	step := nearest + reach - low / self class searchSamples.
	best := ((0 to: self class searchSamples) collect: [:index | low + (step * index)])
		detectMin: [:t | self distanceFrom: aRay at: t].
	^ self
		parameterMinimizingDistanceTo: aRay
		from: (best - step max: low)
		to: best + step
]

{
	#category : #'collisions - private',
	#'squeak_changestamp' : 'phkeese-MCPServer 11/26/2026 16:46'
}
SRCollisionRing >> parameterMinimizingDistanceTo: aRay from: aStart to: anEnd [

	| low high |
	low := aStart.
	high := anEnd.
	self class refinementSteps timesRepeat: [ | middle |
		middle := low + high / 2.
		(self slopeFrom: aRay at: middle) < 0
			ifTrue: [low := middle]
			ifFalse: [high := middle]].
	^ low + high / 2
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
	#category : #'collisions - private',
	#'squeak_changestamp' : 'phkeese-MCPServer 11/26/2026 16:46'
}
SRCollisionRing >> slopeFrom: aRay at: aParameter [

	| point |
	point := aRay project: aParameter.
	^ (point - (self closestPointTo: point)) dot: aRay forward
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
