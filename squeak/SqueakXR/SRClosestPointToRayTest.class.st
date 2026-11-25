"
Tests closestPointToRay: of collision geometries.
"
Class {
	#name : #SRClosestPointToRayTest,
	#superclass : #TestCase,
	#category : #'SqueakXR-Tests-Collisions',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #fixtures,
	#'squeak_changestamp' : 'phkeese-MCPServer 11/25/2026 16:31'
}
SRClosestPointToRayTest >> ringAroundZ [

	^ SRCollisionRing new
		point: Vector3 zero;
		normal: Vector3 forward;
		innerR: 1 m;
		width: 1 m;
		yourself
]

{
	#category : #tests,
	#'squeak_changestamp' : 'phkeese-MCPServer 11/25/2026 16:31'
}
SRClosestPointToRayTest >> testBoundedPlaneMissedByRay [

	| plane ray |
	plane := SRCollisionPlane
		point: Vector3 zero
		normal: 0 @ 0 @ 1
		up: 0 @ 1 @ 0
		width: 2 m
		height: 2 m.
	ray := SRRay origin: 3 @ 0 @ 1 forward: 0 @ 0 @ 1.
	self assert: ((plane closestPointToRay: ray) closeTo: 1 @ 0 @ 0)
]

{
	#category : #tests,
	#'squeak_changestamp' : 'phkeese-MCPServer 11/25/2026 16:31'
}
SRClosestPointToRayTest >> testCompositeYieldsPointOfNearestComponent [

	| composite far ray |
	far := SRCollisionSphere new
		center: 0 @ 10 @ 0;
		radius: 1 m;
		yourself.
	composite := SRCompositeCollision new.
	composite components
		add: far;
		add: self unitSphere;
		add: SRCollisionNull new.
	ray := SRRay origin: 0 @ 3 @ -5 forward: 0 @ 0 @ 1.
	self assert: ((composite closestPointToRay: ray) closeTo: 0 @ 1 @ 0)
]

{
	#category : #tests,
	#'squeak_changestamp' : 'phkeese-MCPServer 11/25/2026 16:31'
}
SRClosestPointToRayTest >> testHittingRayYieldsEntryPoint [

	| ray |
	ray := SRRay origin: 0 @ 0 @ -5 forward: 0 @ 0 @ 1.
	self assert: ((self unitSphere closestPointToRay: ray) closeTo: 0 @ 0 @ -1)
]

{
	#category : #tests,
	#'squeak_changestamp' : 'phkeese-MCPServer 11/25/2026 16:31'
}
SRClosestPointToRayTest >> testRayMeasuresPointsBehindItFromItsOrigin [

	| ray |
	ray := SRRay origin: Vector3 zero forward: 0 @ 0 @ 1.
	self assert: ((ray distanceTo: 0 @ 3 @ -4) closeTo: 5 m).
	self assert: ((ray distanceTo: 0 @ 3 @ 4) closeTo: 3 m)
]

{
	#category : #tests,
	#'squeak_changestamp' : 'phkeese-MCPServer 11/25/2026 16:31'
}
SRClosestPointToRayTest >> testRayThroughRingHole [

	| ray point |
	ray := SRRay origin: 0.2 @ 0 @ -5 forward: 0 @ 0 @ 1.
	point := self ringAroundZ closestPointToRay: ray.
	self assert: (point closeTo: 1 @ 0 @ 0)
]

{
	#category : #tests,
	#'squeak_changestamp' : 'phkeese-MCPServer 11/25/2026 16:31'
}
SRClosestPointToRayTest >> testRingMissedByRay [

	| ray |
	ray := SRRay origin: 5 @ -4 @ 1 forward: 0 @ 1 @ 0.
	self assert: ((self ringAroundZ closestPointToRay: ray) closeTo: 2 @ 0 @ 0)
]

{
	#category : #tests,
	#'squeak_changestamp' : 'phkeese-MCPServer 11/25/2026 16:32'
}
SRClosestPointToRayTest >> testRotatedBoxMissedByRay [

	| box ray |
	box := SRCollisionBox new
		center: Vector3 zero;
		halfExtents: 1 @ 1 @ 1;
		rotation: (Quaternion radiansAngle: Float pi / 4 axis: 0 @ 0 @ 1);
		yourself.
	ray := SRRay origin: -5 @ 3 @ 0 forward: 1 @ 0 @ 0.
	self assert: ((box closestPointToRay: ray) closeTo: 0 @ 2 sqrt @ 0)
]

{
	#category : #tests,
	#'squeak_changestamp' : 'phkeese-MCPServer 11/25/2026 16:31'
}
SRClosestPointToRayTest >> testSphereMissedByRay [

	| ray |
	ray := SRRay origin: 0 @ 3 @ -5 forward: 0 @ 0 @ 1.
	self assert: ((self unitSphere closestPointToRay: ray) closeTo: 0 @ 1 @ 0)
]

{
	#category : #tests,
	#'squeak_changestamp' : 'phkeese-MCPServer 11/25/2026 16:31'
}
SRClosestPointToRayTest >> testSpherePassedByRayPointingAway [

	| ray |
	ray := SRRay origin: 0 @ 3 @ 0 forward: 0 @ 1 @ 0.
	self assert: ((self unitSphere closestPointToRay: ray) closeTo: 0 @ 1 @ 0)
]

{
	#category : #tests,
	#'squeak_changestamp' : 'phkeese-MCPServer 11/25/2026 16:31'
}
SRClosestPointToRayTest >> testUnboundedPlaneFacingAwayFromRay [

	| plane ray |
	plane := SRCollisionPlane point: Vector3 zero normal: 0 @ 1 @ 0.
	ray := SRRay origin: 2 @ 3 @ 4 forward: 0 @ 1 @ 0.
	self assert: ((plane closestPointToRay: ray) closeTo: 2 @ 0 @ 4)
]

{
	#category : #fixtures,
	#'squeak_changestamp' : 'phkeese-MCPServer 11/25/2026 16:31'
}
SRClosestPointToRayTest >> unitSphere [

	^ SRCollisionSphere new
		center: Vector3 zero;
		radius: 1 m;
		yourself
]
