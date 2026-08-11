Class {
	#name : #SRCollisionPlane,
	#superclass : #SRCollisionGeometry,
	#instVars : [
		'normal',
		'point',
		'width',
		'height',
		'up'
	],
	#category : #'SqueakXR-Collisions'
}

{ #category : #'as yet unclassified' }
SRCollisionPlane class >> point: aVector3 normal: anotherVector3 [

	^ self new
		point: aVector3;
		normal: anotherVector3
]

{ #category : #'as yet unclassified' }
SRCollisionPlane class >> point: aVector3 normal: anotherVector3 extent: aPoint [

	^ self new
		point: aVector3;
		normal: anotherVector3;
		extent: aPoint
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/7/2025 15:35'
}
SRCollisionPlane class >> point: point normal: normal up: up width: width height: height [

	self assert: ((normal dot: up) closeTo: 0)
		description: 'normal and up must be orthogonal'.

	^ self new
		point: point;
		normal: normal;
		up: up;
		width: width;
		height: height
]

{
	#category : #collisions,
	#'squeak_changestamp' : 'phkeese 8/11/2026 16:04'
}
SRCollisionPlane >> distanceTo: aPoint [
	| d localPoint b min q v |
	d := (self projected: aPoint) distanceTo: aPoint.
	self isBounded ifFalse: [ ^d ].
	
	v := aPoint - self point.
	localPoint := Vector3 
		x: (v dot: self side)
		y: (v dot: self up)
		z: (v dot: self normal).
	
	b := ((self width)@(self height)@0) / 2.
	q := localPoint abs - b.
	min := ((q x max: q y) max: q z) min: 0.
	^ (((q max: Vector3 zero) length + min) max: d)
	
	
	
]

{ #category : #accessing }
SRCollisionPlane >> extent [

	^ width @ height
]

{ #category : #accessing }
SRCollisionPlane >> height [

	^ height
]

{ #category : #accessing }
SRCollisionPlane >> height: aNumber [

	height := aNumber
]

{ #category : #testing }
SRCollisionPlane >> isBounded [

	^ self up notNil
]

{
	#category : #testing,
	#'squeak_changestamp' : 'SqueakXR 6/25/2026 16:13'
}
SRCollisionPlane >> isCollisionPlane [
	^ true
]

{ #category : #accessing }
SRCollisionPlane >> normal [

	^ normal
]

{ #category : #accessing }
SRCollisionPlane >> normal: aVector3 [

	normal := aVector3
]

{ #category : #accessing }
SRCollisionPlane >> point [

	^ point
]

{ #category : #accessing }
SRCollisionPlane >> point: aVector3 [

	point := aVector3
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 8/11/2026 14:22'
}
SRCollisionPlane >> projected: aPoint [
	| p2p dist |
	p2p := aPoint - self point.
	dist := self normal dot: p2p.
	^ aPoint - (dist * self normal)
]

{ #category : #collisions }
SRCollisionPlane >> rayIntersection: aRay [
	"adapted from
	https://www.scratchapixel.com/lessons/3d-basic-rendering/minimal-ray-tracer-rendering-simple-shapes/ray-plane-and-ray-disk-intersection.html"
	
	| denom delta t intersection centerToIntersection |
	denom := self normal dot: aRay forward.
	denom abs < 1e-6 ifTrue: [^ nil].
	
	delta := self point - aRay origin.
	t := (delta dot: self normal / denom).
	t >= 0 ifFalse: [^ nil].
	
	intersection := aRay project: t.
	
	self isBounded ifFalse: [
		^ SRRayIntersectionResult new
			point: intersection;
			object: self object].
	
	centerToIntersection := intersection - self point.
	((centerToIntersection dot: self up) abs <= (self height / 2)
		and: [(centerToIntersection dot: self side) abs <= (self width / 2)])
		ifFalse: [^ nil]
		ifTrue: [
		^ SRRayIntersectionResult new
			point: intersection;
			object: self object]
]

{ #category : #accessing }
SRCollisionPlane >> side [

	^ self normal cross: self up
]

{ #category : #accessing }
SRCollisionPlane >> up [

	^ up
]

{ #category : #accessing }
SRCollisionPlane >> up: aVector [

	"must be normalized"
	up := aVector
]

{ #category : #accessing }
SRCollisionPlane >> width [

	^ width
]

{ #category : #accessing }
SRCollisionPlane >> width: aNumber [

	width := aNumber
]
