Class {
	#name : #SRCollisionPlane,
	#superclass : #SRCollisionGeometry,
	#instVars : [
		'normal',
		'point',
		'extent'
	],
	#category : #'SqueakXR-Core'
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

{ #category : #accessing }
SRCollisionPlane >> extent [

	"centered on point"
	^ extent
]

{ #category : #accessing }
SRCollisionPlane >> extent: aPoint [

	extent := aPoint
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
	
	| denom delta t |
	denom := self normal dot: aRay forward.
	denom abs < 1e-6 ifTrue: [^ nil].
	delta := self point - aRay origin.
	t := (delta dot: self normal / denom).
	t >= 0
		ifTrue: [
			^ SRRayIntersectionResult new
				point: (aRay project: t)]
		ifFalse: [^ nil]
]
