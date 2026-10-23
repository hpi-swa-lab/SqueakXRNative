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
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 14:59'
}
SRCollisionGeometry >> intersectsBoxCenter: aCentre halfExtents: aHalfExtents [

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
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 14:59'
}
SRCollisionGeometry >> overlapsAlong: anAxis from: aDelta half: aHalfExtent query: aQueryHalfExtents [

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
