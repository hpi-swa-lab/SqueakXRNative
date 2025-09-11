Class {
	#name : #SRCollisionSphere,
	#superclass : #SRCollisionGeometry,
	#instVars : [
		'center',
		'radius'
	],
	#category : #'SqueakXR-Collisions'
}

{ #category : #accessing }
SRCollisionSphere >> center [

	^ center
]

{ #category : #accessing }
SRCollisionSphere >> center: aVector3 [

	center := aVector3
]

{ #category : #accessing }
SRCollisionSphere >> radius [

	^ radius
]

{ #category : #accessing }
SRCollisionSphere >> radius: aNumber [

	radius := aNumber
]

{ #category : #'as yet unclassified' }
SRCollisionSphere >> rayIntersection: aRay [
	"adapted from
	https://www.scratchapixel.com/lessons/3d-basic-rendering/minimal-ray-tracer-rendering-simple-shapes/ray-sphere-intersection.html"
	
	| d2 l t0 t1 tca thc |
	l := self center - aRay origin.
	tca := l dot: aRay forward.
	d2 := l squaredLength - tca squared.
	d2 > self radius squared ifTrue: [^ nil].
	thc := (self radius squared - d2) sqrt.
	t0 := tca - thc.
	t1 := tca + thc.
	
	t0 > t1 ifTrue: [ | temp |
		temp := t0.
		t0 := t1.
		t1 := temp].
	
	t0 < 0 ifTrue: [
		t0 := t1.
		t0 < 0 ifTrue: [^ nil]].
	
	^ SRRayIntersectionResult new
		object: self object;
		point: (aRay project: t0)
	
]
