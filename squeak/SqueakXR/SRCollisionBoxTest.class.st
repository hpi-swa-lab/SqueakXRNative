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
	#category : #'tests - basic AABB',
	#'squeak_changestamp' : 'MCPServer 5/11/2026 17:52'
}
SRCollisionBoxTest >> testRayHitsAxisAlignedBoxCenter [
	"Test ray hitting the center of an axis-aligned box face"
	| box ray result expectedPoint |
	
	box := SRCollisionBox new
		center: Vector3 zero;
		size: Vector3 one;
		rotation: Quaternion identity;
		object: self.
	
	ray := SRRay new
		origin: (Vector3 x: 0 y: 0 z: -5);
		forward: (Vector3 x: 0 y: 0 z: 1).
	
	result := box rayIntersection: ray.
	expectedPoint := Vector3 x: 0 y: 0 z: -0.5.
	
	self assert: result notNil description: 'Ray should hit the box'.
	self assert: (result object == self) description: 'Result should reference the test object'.
	self assert: (result point closeTo: expectedPoint)
]

{
	#category : #'tests - basic AABB',
	#'squeak_changestamp' : 'MCPServer 5/11/2026 17:52'
}
SRCollisionBoxTest >> testRayHitsBoxCorner [
	"Test ray hitting near the corner of a box"
	| box ray result expectedPoint |
	
	box := SRCollisionBox new
		center: Vector3 zero;
		size: Vector3 one;
		rotation: Quaternion identity;
		object: self.
	
	ray := SRRay new
		origin: (Vector3 x: 0.4 y: 0.4 z: -5);
		forward: (Vector3 x: 0 y: 0 z: 1).
	
	result := box rayIntersection: ray.
	expectedPoint := Vector3 x: 0.4 y: 0.4 z: -0.5.
	
	self assert: result notNil description: 'Ray should hit the box near corner'.
	self assert: (result point closeTo: expectedPoint)
]

{
	#category : #'tests - OBB',
	#'squeak_changestamp' : 'MCPServer 5/11/2026 17:53'
}
SRCollisionBoxTest >> testRayHitsRotatedBox [
	"Test ray hitting a box rotated 45 degrees around Y axis"
	| box ray result q expectedPoint |
	
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
	expectedPoint := Vector3 x: 0 y: 0 z: (Float pi / 4) cos negated.
	
	self assert: result notNil description: 'Ray should hit rotated box'.
	self assert: (result point closeTo: expectedPoint)
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
	#'squeak_changestamp' : 'MCPServer 5/11/2026 17:52'
}
SRCollisionBoxTest >> testRayPointingAway [
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
	#category : #'tests - edge cases',
	#'squeak_changestamp' : 'MCPServer 5/11/2026 17:53'
}
SRCollisionBoxTest >> testRayStartsInsideBox [
	"Test ray that starts inside the box"
	| box ray result expectedPoint |
	
	box := SRCollisionBox new
		center: Vector3 zero;
		size: (Vector3 x: 2 y: 2 z: 2);
		rotation: Quaternion identity;
		object: self.
	
	ray := SRRay new
		origin: Vector3 zero;
		forward: (Vector3 x: 0 y: 0 z: 1).
	
	result := box rayIntersection: ray.
	expectedPoint := Vector3 x: 0 y: 0 z: 1.
	
	self assert: result notNil description: 'Ray starting inside should still hit exit point'.
	self assert: (result point closeTo: expectedPoint)
]
