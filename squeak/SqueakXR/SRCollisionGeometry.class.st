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

{ #category : #collisions }
SRCollisionGeometry >> intersectsWithRay: aRay [

	^ (self rayIntersection: aRay) notNil
]

{
	#category : #testing,
	#'squeak_changestamp' : 'MCPServer 6/8/2026 15:46'
}
SRCollisionGeometry >> isCollisionBox [
	^ false.
]

{
	#category : #testing,
	#'squeak_changestamp' : 'MCPServer 6/8/2026 15:46'
}
SRCollisionGeometry >> isCollisionPlane [
	^ false.
]

{ #category : #accessing }
SRCollisionGeometry >> object [

	^ object
]

{ #category : #accessing }
SRCollisionGeometry >> object: aSRObject [

	object := aSRObject
]

{ #category : #collisions }
SRCollisionGeometry >> rayIntersection: aRay [

	^ self subclassResponsibility
]
