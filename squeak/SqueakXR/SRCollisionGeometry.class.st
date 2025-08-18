Class {
	#name : #SRCollisionGeometry,
	#superclass : #Object,
	#instVars : [
		'object'
	],
	#category : #'SqueakXR-Core'
}

{ #category : #'as yet unclassified' }
SRCollisionGeometry class >> toolIcon [

	^ #srcollision
]

{ #category : #collisions }
SRCollisionGeometry >> intersectsWithRay: aRay [

	^ (self rayIntersection: aRay) notNil
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
