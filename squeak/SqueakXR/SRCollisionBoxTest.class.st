"
Test cases for SRCollisionBox oriented bounding box collision detection.
"
Class {
	#name : #SRCollisionBoxTest,
	#superclass : #TestCase,
	#category : #'SqueakXR-Tests-Collisions',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #'tests - basic',
	#'squeak_changestamp' : 'MCPServer 4/30/2026 11:53'
}
SRCollisionBoxTest >> testAccessors [
	"Test basic accessor methods"
	| box center halfExtents rotation |
	
	center := Vector3 x: 1 y: 2 z: 3.
	halfExtents := Vector3 x: 0.5 y: 1.0 z: 1.5.
	rotation := Quaternion radiansAngle: Float pi / 6 axis: (Vector3 x: 0 y: 0 z: 1).
	
	box := SRCollisionBox new
		center: center;
		halfExtents: halfExtents;
		rotation: rotation;
		object: self.
	
	self assert: box center equals: center.
	self assert: box halfExtents equals: halfExtents.
	self assert: box rotation equals: rotation.
	self assert: box object equals: self.
	
	"Test size convenience methods"
	self assert: box size equals: (halfExtents * 2).
	
	box size: (Vector3 x: 4 y: 6 z: 8).
	self assert: box halfExtents equals: (Vector3 x: 2 y: 3 z: 4)
]

{
	#category : #'tests - edge cases',
	#'squeak_changestamp' : 'MCPServer 4/30/2026 11:52'
}
SRCollisionBoxTest >> testRayFromBehind [
	"Test ray pointing away from the box"
	| box ray result |
	
	box := SRCollisionBox new
		center: Vector3 zero;
		size: Vector3 one;
		rotation: Quaternion identity;
		object: self.
	
	ray := SRRay new
		origin: (Vector3 x: 0 y: 0 z: -5);
		forward: (Vector3 x: 0 y: 0 z: -1).
	
	result := box rayIntersection: ray.
	
	self assert: result isNil description: 'Ray pointing away should miss'
]

{
	#category : #'tests - basic AABB',
	#'squeak_changestamp' : 'MCPServer 4/30/2026 11:52'
}
SRCollisionBoxTest >> testRayHitsAxisAlignedBoxCenter [
	"Test ray hitting the center of an axis-aligned box face"
	| box ray result |
	
	box := SRCollisionBox new
		center: Vector3 zero;
		size: Vector3 one;
		rotation: Quaternion identity;
		object: self.
	
	ray := SRRay new
		origin: (Vector3 x: 0 y: 0 z: -5);
		forward: (Vector3 x: 0 y: 0 z: 1).
	
	result := box rayIntersection: ray.
	
	self assert: result notNil description: 'Ray should hit the box'.
	self assert: (result object == self) description: 'Result should reference the test object'.
	self assert: (result point x closeTo: 0.0) description: 'Hit x should be 0'.
	self assert: (result point y closeTo: 0.0) description: 'Hit y should be 0'.
	self assert: (result point z closeTo: -0.5) description: 'Hit z should be at front face (-0.5)'
]

{
	#category : #'tests - basic AABB',
	#'squeak_changestamp' : 'MCPServer 4/30/2026 11:53'
}
SRCollisionBoxTest >> testRayHitsBoxCorner [
	"Test ray hitting near the corner of a box (important for box vs sphere comparison)"
	| box ray result |
	
	box := SRCollisionBox new
		center: Vector3 zero;
		size: Vector3 one;
		rotation: Quaternion identity;
		object: self.
	
	"Ray aimed at a point near the corner (0.4, 0.4, z) which is inside a 1x1 box"
	ray := SRRay new
		origin: (Vector3 x: 0.4 y: 0.4 z: -5);
		forward: (Vector3 x: 0 y: 0 z: 1).
	
	result := box rayIntersection: ray.
	
	self assert: result notNil description: 'Ray should hit the box near corner'.
	self assert: (result point x closeTo: 0.4).
	self assert: (result point y closeTo: 0.4).
	self assert: (result point z closeTo: -0.5)
]

{
	#category : #'tests - OBB',
	#'squeak_changestamp' : 'MCPServer 4/30/2026 11:53'
}
SRCollisionBoxTest >> testRayHitsRotatedBox [
	"Test ray hitting a box rotated 45 degrees around Y axis"
	| box ray result q |
	
	q := Quaternion radiansAngle: Float pi / 4 axis: (Vector3 x: 0 y: 1 z: 0).
	box := SRCollisionBox new
		center: Vector3 zero;
		size: (Vector3 x: 2 y: 1 z: 1);
		rotation: q;
		object: self.
	
	ray := SRRay new
		origin: (Vector3 x: 0 y: 0 z: -5);
		forward: (Vector3 x: 0 y: 0 z: 1).
	
	result := box rayIntersection: ray.
	
	self assert: result notNil description: 'Ray should hit rotated box'.
	self assert: (result point x closeTo: 0.0).
	self assert: (result point y closeTo: 0.0).
	"For a 2x1x1 box rotated 45Â° around Y, the front face is closer to camera"
	self assert: result point z < 0 description: 'Hit should be in front of origin'
]

{
	#category : #'tests - basic AABB',
	#'squeak_changestamp' : 'MCPServer 4/30/2026 11:52'
}
SRCollisionBoxTest >> testRayMissesAxisAlignedBox [
	"Test ray missing an axis-aligned box"
	| box ray result |
	
	box := SRCollisionBox new
		center: Vector3 zero;
		size: Vector3 one;
		rotation: Quaternion identity;
		object: self.
	
	ray := SRRay new
		origin: (Vector3 x: 10 y: 0 z: -5);
		forward: (Vector3 x: 0 y: 0 z: 1).
	
	result := box rayIntersection: ray.
	
	self assert: result isNil description: 'Ray should miss the box'
]

{
	#category : #'tests - edge cases',
	#'squeak_changestamp' : 'MCPServer 4/30/2026 11:53'
}
SRCollisionBoxTest >> testRayParallelToBoxFace [
	"Test ray parallel to a box face (edge case for division by zero)"
	| box ray result |
	
	box := SRCollisionBox new
		center: Vector3 zero;
		size: Vector3 one;
		rotation: Quaternion identity;
		object: self.
	
	"Ray parallel to XY plane, passing through the box"
	ray := SRRay new
		origin: (Vector3 x: -2 y: 0 z: 0);
		forward: (Vector3 x: 1 y: 0 z: 0).
	
	result := box rayIntersection: ray.
	
	self assert: result notNil description: 'Parallel ray through box should hit'.
	self assert: (result point x closeTo: -0.5) description: 'Should hit left face'
]

{
	#category : #'tests - edge cases',
	#'squeak_changestamp' : 'MCPServer 4/30/2026 11:53'
}
SRCollisionBoxTest >> testRayStartsInsideBox [
	"Test ray that starts inside the box"
	| box ray result |
	
	box := SRCollisionBox new
		center: Vector3 zero;
		size: (Vector3 x: 2 y: 2 z: 2);
		rotation: Quaternion identity;
		object: self.
	
	ray := SRRay new
		origin: Vector3 zero;
		forward: (Vector3 x: 0 y: 0 z: 1).
	
	result := box rayIntersection: ray.
	
	self assert: result notNil description: 'Ray starting inside should still hit exit point'.
	self assert: (result point z closeTo: 1.0) description: 'Should hit back face at z=1'
]
