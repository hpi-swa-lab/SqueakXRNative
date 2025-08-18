Class {
	#name : #SRRayIntersectionResult,
	#superclass : #Object,
	#instVars : [
		'point'
	],
	#category : #'SqueakXR-Core'
}

{ #category : #'as yet unclassified' }
SRRayIntersectionResult >> point [

	"in global space"
	^ point
]

{ #category : #'as yet unclassified' }
SRRayIntersectionResult >> point: aVector3 [

	point := aVector3
]
