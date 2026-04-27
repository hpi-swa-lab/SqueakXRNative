Class {
	#name : #SRRayIntersectionResult,
	#superclass : #Object,
	#instVars : [
		'point',
		'object'
	],
	#category : #'SqueakXR-Collisions'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 4/8/2026 15:52'
}
SRRayIntersectionResult >> asHandRayIntersection: actionState [

	^ SRHandRayIntersectionResult new
		object: self object;
		point: self point;
		actionState: actionState
]

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
