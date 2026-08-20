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
	#category : #testing,
	#'squeak_changestamp' : 'phkeese 8/10/2026 17:19'
}
SRCollisionBox >> contains: aPoint [
	| inverseRotation localOrigin min max|
	inverseRotation := self rotation inverse.
	localOrigin := inverseRotation rotateVector: (aPoint - self center).
	min := self center - self halfExtents.
	max := self center + self halfExtents.
	^ ((localOrigin x >= min x) 
	and: [ localOrigin x <= max x]
	and: [ localOrigin y >= min y]
	and: [ localOrigin y <= max y]
	and: [ localOrigin z >= min z])
	and: [ localOrigin z <= max z]
]

{
	#category : #collisions,
	#'squeak_changestamp' : 'phkeese 8/11/2026 16:20'
}
SRCollisionBox >> distanceTo: aPoint [
	| inverseRotation localPoint b min q |
	inverseRotation := self rotation inverse.
	localPoint := inverseRotation rotateVector: (aPoint - self center).
	b := self halfExtents.
	q := localPoint abs - b.
	min := ((q x max: q y) max: q z) min: 0.
	^ ((q max: Vector3 zero) length + min)
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
	#category : #debugging,
	#'squeak_changestamp' : 'phkeese 8/20/2026 16:57'
}
SRCollisionBox >> renderOn: aRenderer [
	| xform |
	xform := (Matrix4x4 
		fromQuaternion: self rotation)
		scaling: self halfExtents;
		translation: self center;
		yourself.
	aRenderer renderWireCubeTransformed: xform withColor: Color black.
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
