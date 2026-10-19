Class {
	#name : #SRCollisionGeometry,
	#superclass : #Object,
	#instVars : [
		'object'
	],
	#category : #'SqueakXR-Collisions'
}

{ #category : #'as yet unclassified' }
SRCollisionGeometry class >> toolIcon [

	^ #srcollision
]

{
	#category : #testing,
	#'squeak_changestamp' : 'SqueakXR 6/26/2026 16:17'
}
SRCollisionGeometry >> ifCollisionGeometry: aBlock [

	^ aBlock value: self
]

{
	#category : #collisions,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/19/2026 14:39'
}
SRCollisionGeometry >> intersectsBoxCenter: aCentre halfExtents: aHalfExtents [
	"Overlap with an axis-aligned box in global space, as the locomotion sweep asks
	it. An implementation may answer true for a near miss but never false for a
	real overlap: a conservative collider stops the player short of a wall, an
	optimistic one lets them walk through it."

	^ self subclassResponsibility
]

{ #category : #collisions }
SRCollisionGeometry >> intersectsWithRay: aRay [

	^ (self rayIntersection: aRay) notNil
]

{
	#category : #testing,
	#'squeak_changestamp' : 'SqueakXR 6/26/2026 16:09'
}
SRCollisionGeometry >> isCollisionBox [

	^ false
]

{
	#category : #testing,
	#'squeak_changestamp' : 'leo 9/29/2026 16:43'
}
SRCollisionGeometry >> isCollisionGeometry [

	^ true
]

{
	#category : #testing,
	#'squeak_changestamp' : 'SqueakXR 6/26/2026 16:13'
}
SRCollisionGeometry >> isCollisionNull [

	^ false
]

{
	#category : #testing,
	#'squeak_changestamp' : 'SqueakXR 6/26/2026 16:09'
}
SRCollisionGeometry >> isCollisionPlane [

	^ false
]

{ #category : #accessing }
SRCollisionGeometry >> object [

	^ object
]

{ #category : #accessing }
SRCollisionGeometry >> object: aSRObject [

	object := aSRObject
]

{
	#category : #collisions,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/19/2026 14:39'
}
SRCollisionGeometry >> overlapsAlong: anAxis from: aDelta half: aHalfExtent query: aQueryHalfExtents [
	"One separating-axis test. The query box is axis aligned in global space, so its
	support along anAxis is the axis's absolute components dotted with its half
	extents."

	| support |
	support := (anAxis x abs * aQueryHalfExtents x)
		+ (anAxis y abs * aQueryHalfExtents y)
		+ (anAxis z abs * aQueryHalfExtents z).
	^ (aDelta dot: anAxis) abs <= (aHalfExtent + support)
]

{ #category : #collisions }
SRCollisionGeometry >> rayIntersection: aRay [

	^ self subclassResponsibility
]
