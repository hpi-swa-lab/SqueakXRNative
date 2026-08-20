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

{
	#category : #testing,
	#'squeak_changestamp' : 'phkeese 8/11/2026 15:29'
}
SRCollisionSphere >> distanceTo: aPoint [
	^ (self center distanceTo: aPoint) - (self radius / 2)
]

{ #category : #accessing }
SRCollisionSphere >> radius [

	^ radius
]

{ #category : #accessing }
SRCollisionSphere >> radius: aNumber [

	radius := aNumber
]

{ #category : #collisions }
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

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 8/20/2026 16:58'
}
SRCollisionSphere >> renderOn: aRenderer [
	| xform |
	xform := (Matrix4x4 withOffset: self center) scaling: self radius asVector3.
	aRenderer renderWireSphereTransformed: xform withColor: Color black.
]
