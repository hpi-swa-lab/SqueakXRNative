Class {
	#name : #SRRayIntersectionResult,
	#superclass : #Object,
	#instVars : [
		'point',
		'object'
	],
	#category : #'SqueakXR-Collisions'
}

{ #category : #'as yet unclassified' }
SRRayIntersectionResult >> object [

	^ object
]

{ #category : #'as yet unclassified' }
SRRayIntersectionResult >> object: aSRObject [

	object := aSRObject
]

{ #category : #'as yet unclassified' }
SRRayIntersectionResult >> point [

	"in global space"
	^ point
]

{ #category : #'as yet unclassified' }
SRRayIntersectionResult >> point: aVector3 [

	point := aVector3
]
