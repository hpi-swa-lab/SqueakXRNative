Class {
	#name : #SRCollisionPlane,
	#superclass : #SRCollisionGeometry,
	#instVars : [
		'normal',
		'point',
		'extent',
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

{ #category : #'as yet unclassified' }
SRCollisionPlane class >> point: point normal: normal up: up width: width height: height [

	self assert: (normal dot: up) = 0
		description: 'normal and up must be orthogonal'.

	^ self new
		point: point;
		normal: normal;
		up: up;
		width: width;
		height: height
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
