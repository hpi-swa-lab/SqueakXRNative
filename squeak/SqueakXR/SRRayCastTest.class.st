Class {
	#name : #SRRayCastTest,
	#superclass : #TestCase,
	#category : #'SqueakXR-Core-Tests'
}

{ #category : #'as yet unclassified' }
SRRayCastTest >> testBoundedPlaneIntersection [

	| ray plane |
	ray := SRRay
		origin: 0 @ 1 @ 1
		forward: 1 @ 0 @ 0.
	plane := SRCollisionPlane
		point: 2 @ 0 @ 0
		normal: -1 @ 0 @ 0
		up: 0 @ 1 @ 0
		width: 4
		height: 3.
	
	self assert: (plane intersectsWithRay: ray).
	
	ray origin: 0 @ 10 @ 0.
	self assert: (plane intersectsWithRay: ray) not.
]

{ #category : #'as yet unclassified' }
SRRayCastTest >> testPlaneCollisionGeometry [

	| plane |
	plane := SRPlane new.
]

{ #category : #'as yet unclassified' }
SRRayCastTest >> testProjectRay [

	| ray |
	ray := SRRay
		origin: 0 @ 0 @ 0
		forward: 1 @ 0 @ 0.
	
	self assert: ((ray project: 10) = (10 @ 0 @ 0))
]

{ #category : #'as yet unclassified' }
SRRayCastTest >> testUnboundedPlaneIntersection [

	| ray plane |
	ray := SRRay
		origin: 0 @ 0 @ 0
		forward: 1 @ 0 @ 0.
	plane := SRCollisionPlane
		point: 2 @ 0 @ 0
		normal: -1 @ 0 @ 0.
	
	self assert: (plane intersectsWithRay: ray).
	self assert: (plane rayIntersection: ray) point = (2 @ 0 @ 0).
	
	plane point: 2 @ 10 @ 100.
	self assert: (plane rayIntersection: ray) point = (2 @ 0 @ 0).
	
	ray forward: ((1 @ 1 @ 1) normalize).
	self assert: (plane rayIntersection: ray) point = (2 @ 2 @ 2).
]
