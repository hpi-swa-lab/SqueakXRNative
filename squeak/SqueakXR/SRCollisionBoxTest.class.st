"
Tests for SRCollisionBox.
"
Class {
	#name : #SRCollisionBoxTest,
	#superclass : #TestCase,
	#category : #'SqueakXR-Tests-Collisions',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #'tests - basic',
	#'squeak_changestamp' : 'MCPServer 5/13/2026 13:56'
}
SRCollisionBoxTest >> testAccessors [

	| box center halfExtents rotation |
	center := 1 @ 2 @ 3.
	halfExtents := 0.5 @ 1.0 @ 1.5.
	rotation := Quaternion radiansAngle: Float pi / 6 axis: (0 @ 0 @ 1).
	box := SRCollisionBox new
		center: center;
		halfExtents: halfExtents;
		rotation: rotation;
		object: self.
	self assert: box center equals: center.
	self assert: box halfExtents equals: halfExtents.
	self assert: box rotation equals: rotation.
	self assert: box object equals: self.
	self assert: box size equals: (halfExtents * 2).
	box size: (4 @ 6 @ 8).
	self assert: box halfExtents equals: (2 @ 3 @ 4)
]

{
	#category : #'tests - basic AABB',
	#'squeak_changestamp' : 'MCPServer 5/13/2026 13:57'
}
SRCollisionBoxTest >> testRayHitsAxisAlignedBoxCenter [

	| box ray result |
	box := SRCollisionBox new
		center: Vector3 zero;
		size: Vector3 one;
		rotation: Quaternion identity;
		object: self.
	ray := SRRay new
		origin: (0 @ 0 @ -5);
		forward: (0 @ 0 @ 1).
	result := box rayIntersection: ray.
	self assert: result notNil.
	self assert: result object equals: self.
	self assert: (result point closeTo: (0 @ 0 @ -0.5))
]

{
	#category : #'tests - basic AABB',
	#'squeak_changestamp' : 'MCPServer 5/13/2026 13:57'
}
SRCollisionBoxTest >> testRayHitsBoxCorner [

	| box ray result |
	box := SRCollisionBox new
		center: Vector3 zero;
		size: Vector3 one;
		rotation: Quaternion identity;
		object: self.
	ray := SRRay new
		origin: (0.4 @ 0.4 @ -5);
		forward: (0 @ 0 @ 1).
	result := box rayIntersection: ray.
	self assert: result notNil.
	self assert: (result point closeTo: (0.4 @ 0.4 @ -0.5))
]

{
	#category : #'tests - OBB',
	#'squeak_changestamp' : 'MCPServer 5/13/2026 13:57'
}
SRCollisionBoxTest >> testRayHitsRotatedBox [

	| box ray result q |
	q := Quaternion radiansAngle: Float pi / 4 axis: (0 @ 1 @ 0).
	box := SRCollisionBox new
		center: Vector3 zero;
		size: (2 @ 1 @ 1);
		rotation: q;
		object: self.
	ray := SRRay new
		origin: (0 @ 0 @ -5);
		forward: (0 @ 0 @ 1).
	result := box rayIntersection: ray.
	self assert: result notNil.
	self assert: (result point closeTo: (0 @ 0 @ (Float pi / 4) cos negated))
]

{
	#category : #'tests - basic AABB',
	#'squeak_changestamp' : 'MCPServer 5/13/2026 13:57'
}
SRCollisionBoxTest >> testRayMissesAxisAlignedBox [

	| box ray result |
	box := SRCollisionBox new
		center: Vector3 zero;
		size: Vector3 one;
		rotation: Quaternion identity;
		object: self.
	ray := SRRay new
		origin: (10 @ 0 @ -5);
		forward: (0 @ 0 @ 1).
	result := box rayIntersection: ray.
	self assert: result isNil
]

{
	#category : #'tests - edge cases',
	#'squeak_changestamp' : 'MCPServer 5/13/2026 13:57'
}
SRCollisionBoxTest >> testRayPointingAway [

	| box ray result |
	box := SRCollisionBox new
		center: Vector3 zero;
		size: Vector3 one;
		rotation: Quaternion identity;
		object: self.
	ray := SRRay new
		origin: (0 @ 0 @ -5);
		forward: (0 @ 0 @ -1).
	result := box rayIntersection: ray.
	self assert: result isNil
]

{
	#category : #'tests - edge cases',
	#'squeak_changestamp' : 'MCPServer 5/13/2026 13:57'
}
SRCollisionBoxTest >> testRayStartsInsideBox [

	| box ray result |
	box := SRCollisionBox new
		center: Vector3 zero;
		size: (2 @ 2 @ 2);
		rotation: Quaternion identity;
		object: self.
	ray := SRRay new
		origin: Vector3 zero;
		forward: (0 @ 0 @ 1).
	result := box rayIntersection: ray.
	self assert: result notNil.
	self assert: (result point closeTo: (0 @ 0 @ 1))
]
