Class {
	#name : #SRCollisionGeometry,
	#superclass : #Object,
	#category : #'SqueakXR-Core'
}

{ #category : #collisions }
SRCollisionGeometry >> intersectsWithRay: aRay [

	^ (self rayIntersection: aRay) notNil
]

{ #category : #collisions }
SRCollisionGeometry >> rayIntersection: aRay [

	^ self subclassResponsibility
]
