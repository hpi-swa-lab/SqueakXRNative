"
I represent an oriented bounding box (OBB) for collision detection.

Instance Variables:
	center - Vector3 - The center position of the box in world space
	halfExtents - Vector3 - Half the size of the box in each dimension (local space)
	rotation - Quaternion - The orientation of the box

Usage:
	box := SRCollisionBox new
		center: Vector3 zero;
		halfExtents: (Vector3 x: 0.5 y: 0.5 z: 0.5);  ""1x1x1 box""
		rotation: Quaternion identity;
		object: someObject.
	
	result := box rayIntersection: aRay.

The box supports arbitrary rotations (OBB) by transforming rays into the box's local coordinate space where it becomes an axis-aligned bounding box (AABB), performing the intersection test, then transforming the result back to world space.
"
Class {
	#name : #SRCollisionBox,
	#superclass : #SRCollisionGeometry,
	#instVars : [
		'center',
		'halfExtents',
		'rotation'
	],
	#category : #'SqueakXR-Collisions',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 4/30/2026 11:48'
}
SRCollisionBox >> center [

	^ center
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 4/30/2026 11:48'
}
SRCollisionBox >> center: aVector3 [

	center := aVector3
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 4/30/2026 11:48'
}
SRCollisionBox >> halfExtents [

	^ halfExtents
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 4/30/2026 11:48'
}
SRCollisionBox >> halfExtents: aVector3 [

	halfExtents := aVector3
]

{
	#category : #collisions,
	#'squeak_changestamp' : 'MCPServer 4/30/2026 11:49'
}
SRCollisionBox >> rayIntersection: aRay [
	"OBB ray intersection via transformation to local space.
	Transform ray to box's local coordinate space, perform AABB test,
	then transform hit point back to world space."
	| localRay inverseRotation localOrigin localDirection hitT localHitPoint worldHitPoint |
	
	"Transform ray to box's local coordinate space"
	inverseRotation := self rotation inverse.
	localOrigin := inverseRotation rotateVector: (aRay origin - self center).
	localDirection := inverseRotation rotateVector: aRay forward.
	
	"Create local-space ray"
	localRay := SRRay new
		origin: localOrigin;
		forward: localDirection.
	
	"Perform AABB intersection in local space"
	hitT := self rayIntersectionAABB: localRay.
	hitT ifNil: [^ nil].
	
	"Transform hit point back to world space"
	localHitPoint := localRay project: hitT.
	worldHitPoint := (self rotation rotateVector: localHitPoint) + self center.
	
	^ SRRayIntersectionResult new
		object: self object;
		point: worldHitPoint
]

{
	#category : #'collisions - private',
	#'squeak_changestamp' : 'MCPServer 4/30/2026 11:49'
}
SRCollisionBox >> rayIntersectionAABB: aLocalRay [
	"Axis-aligned bounding box intersection in local space using slab method.
	Returns t value or nil if no intersection.
	Adapted from: https://www.scratchapixel.com/lessons/3d-basic-rendering/minimal-ray-tracer-rendering-simple-shapes/ray-box-intersection"
	| tmin tmax bmin bmax |
	
	bmin := self halfExtents negated.
	bmax := self halfExtents.
	
	tmin := Float negativeInfinity.
	tmax := Float infinity.
	
	"Test each axis (X, Y, Z)"
	#(x y z) do: [:axis |
		| rayOrigin rayDir boxMin boxMax t1 t2 temp |
		rayOrigin := aLocalRay origin perform: axis.
		rayDir := aLocalRay forward perform: axis.
		boxMin := bmin perform: axis.
		boxMax := bmax perform: axis.
		
		"Handle ray parallel to slab"
		rayDir abs < 1e-6 ifTrue: [
			"Ray parallel to slab - check if inside"
			(rayOrigin < boxMin or: [rayOrigin > boxMax]) ifTrue: [^ nil].
		] ifFalse: [
			"Calculate intersection with both planes"
			t1 := (boxMin - rayOrigin) / rayDir.
			t2 := (boxMax - rayOrigin) / rayDir.
			
			"Ensure t1 < t2"
			t1 > t2 ifTrue: [temp := t1. t1 := t2. t2 := temp].
			
			"Update overall min/max"
			tmin := tmin max: t1.
			tmax := tmax min: t2.
			
			"Early exit if slabs don't overlap"
			tmax < tmin ifTrue: [^ nil].
		].
	].
	
	"Check if intersection is in front of ray"
	tmax < 0 ifTrue: [^ nil].
	
	"Return closest positive t"
	^ tmin < 0 ifTrue: [tmax] ifFalse: [tmin]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 4/30/2026 11:48'
}
SRCollisionBox >> rotation [

	^ rotation
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 4/30/2026 11:48'
}
SRCollisionBox >> rotation: aQuaternion [

	rotation := aQuaternion
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 4/30/2026 11:48'
}
SRCollisionBox >> size [
	"Return the full size of the box (2 * halfExtents)"

	^ self halfExtents * 2
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 4/30/2026 11:48'
}
SRCollisionBox >> size: aVector3 [
	"Set the full size of the box (halfExtents = size / 2)"

	self halfExtents: aVector3 / 2
]
