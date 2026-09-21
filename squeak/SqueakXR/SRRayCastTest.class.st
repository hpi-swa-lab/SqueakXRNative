Class {
	#name : #SRRayCastTest,
	#superclass : #TestCase,
	#category : #'SqueakXR-Tests-Collisions'
}

{
	#category : #helpers,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 16:07'
}
SRRayCastTest >> planeAtZ: aNumber [
	"Faces -Z, so a ray cast along +Z from the origin hits it head on."

	^ SRPlane new
		position: 0 @ 0 @ aNumber;
		rotation: (Quaternion angle: -90 axis: 1 @ 0 @ 0);
		yourself
]

{
	#category : #helpers,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 16:07'
}
SRRayCastTest >> rayAlongZ [

	^ SRRay origin: 0 @ 0 @ 0 forward: 0 @ 0 @ 1
]

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
	
	ray origin: 0 @ -10 @ 0.
	self assert: (plane intersectsWithRay: ray) not.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 16:07'
}
SRRayCastTest >> testCastAllWalksNestedChildren [

	| root group near mid far intersections |
	root := SRObject new.
	group := SRObject new.
	near := self planeAtZ: 1.
	mid := self planeAtZ: 2.
	far := self planeAtZ: 3.
	root addChild: far.
	root addChild: group.
	group addChild: near.
	group addChild: mid.
	intersections := self rayAlongZ castAll: root.

	self assert: (intersections collect: [:each | each object]) asArray equals: {near. mid. far}.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 16:08'
}
SRRayCastTest >> testCastNearestWalksNestedChildren [

	| root group near far |
	root := SRObject new.
	group := SRObject new.
	near := self planeAtZ: 1.
	far := self planeAtZ: 3.
	root addChild: far.
	root addChild: group.
	group addChild: near.

	self assert: (self rayAlongZ castNearest: root) object == near.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 16:07'
}
SRRayCastTest >> testCastWithoutHitAnswersNothing [

	self assert: (self rayAlongZ castAll: SRObject new) isEmpty.
	self assert: (self rayAlongZ castNearest: SRObject new) isNil.
	self assert: (self rayAlongZ castNearestObjects: #()) isNil.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MCPServer 9/18/2026 16:07'
}
SRRayCastTest >> testIntersectionsAreSortedByDistance [

	| near mid far intersections |
	near := self planeAtZ: 1.
	mid := self planeAtZ: 2.
	far := self planeAtZ: 3.
	intersections := self rayAlongZ castAllObjects: {far. near. mid}.

	self assert: (intersections collect: [:each | each object]) asArray equals: {near. mid. far}.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 2/23/2026 16:11'
}
SRRayCastTest >> testPlaneCollisionGeometry [

	| plane collisionGeometry |
	plane := SRPlane new scale: 2 @ 1 @ 3.
	collisionGeometry := plane collisionGeometry.
	
	self assert: (collisionGeometry normal = (0 @ 1 @ 0)).
	self assert: (collisionGeometry up = (0 @ 0 @ 1)).
	self assert: (collisionGeometry width = 2).
	self assert: (collisionGeometry height = 3).
	
	plane rotation: (Quaternion angle: 90 axis: 1 @ 0 @ 0).
	collisionGeometry := plane collisionGeometry.
	
	self assert: (collisionGeometry normal = (0 @ 0 @ 1)).
	self assert: (collisionGeometry up = (0 @ -1 @ 0)).
	self assert: (collisionGeometry width = 2).
	self assert: (collisionGeometry height = 3).
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
