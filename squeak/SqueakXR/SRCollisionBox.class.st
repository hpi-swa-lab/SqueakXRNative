"
Oriented bounding box (OBB) for ray intersection tests.
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
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/19/2026 14:40'
}
SRCollisionBox >> intersectsBoxCenter: aCentre halfExtents: aHalfExtents [
	"Separating axes are taken from this box only, not from the query box, so a
	rotated box can report an overlap a few millimetres before it has one. Erring
	that way is the direction the superclass requires."

	| delta |
	delta := aCentre - self center.
	^ (self
		overlapsAlong: (self rotation rotateVector: Vector3 right)
		from: delta
		half: self halfExtents x
		query: aHalfExtents)
		and: [(self
			overlapsAlong: (self rotation rotateVector: Vector3 up)
			from: delta
			half: self halfExtents y
			query: aHalfExtents)
			and: [self
				overlapsAlong: (self rotation rotateVector: Vector3 forward)
				from: delta
				half: self halfExtents z
				query: aHalfExtents]]
]

{
	#category : #testing,
	#'squeak_changestamp' : 'MCPServer 6/8/2026 15:46'
}
SRCollisionBox >> isCollisionBox [
	^ true.
]

{
	#category : #collisions,
	#'squeak_changestamp' : 'MCPServer 5/13/2026 13:56'
}
SRCollisionBox >> rayIntersection: aRay [
	"OBB ray intersection via transformation to local AABB space."

	| inverseRotation localOrigin localDirection localRay hitT localHitPoint |
	inverseRotation := self rotation inverse.
	localOrigin := inverseRotation rotateVector: (aRay origin - self center).
	localDirection := inverseRotation rotateVector: aRay forward.
	localRay := SRRay new
		origin: localOrigin;
		forward: localDirection.
	hitT := self rayIntersectionAABB: localRay.
	hitT ifNil: [^ nil].
	localHitPoint := localRay project: hitT.
	^ SRRayIntersectionResult new
		object: self object;
		point: (self rotation rotateVector: localHitPoint) + self center
]

{
	#category : #'collisions - private',
	#'squeak_changestamp' : 'MCPServer 5/13/2026 13:56'
}
SRCollisionBox >> rayIntersectionAABB: aLocalRay [
	"Slab method AABB intersection. Returns t value or nil."

	| tmin tmax bmin bmax |
	bmin := self halfExtents negated.
	bmax := self halfExtents.
	tmin := Float negativeInfinity.
	tmax := Float infinity.
	#(x y z) do: [:axis |
		| rayOrigin rayDir boxMin boxMax t1 t2 temp |
		rayOrigin := aLocalRay origin perform: axis.
		rayDir := aLocalRay forward perform: axis.
		boxMin := bmin perform: axis.
		boxMax := bmax perform: axis.
		(rayDir closeTo: 0)
			ifTrue: [
				(rayOrigin < boxMin or: [rayOrigin > boxMax]) ifTrue: [^ nil]]
			ifFalse: [
				t1 := (boxMin - rayOrigin) / rayDir.
				t2 := (boxMax - rayOrigin) / rayDir.
				t1 > t2 ifTrue: [temp := t1. t1 := t2. t2 := temp].
				tmin := tmin max: t1.
				tmax := tmax min: t2.
				tmax < tmin ifTrue: [^ nil]]].
	tmax < 0 ifTrue: [^ nil].
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
