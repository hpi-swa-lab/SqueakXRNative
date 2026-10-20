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
	#category : #converting,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/20/2026 10:42'
}
SRRayIntersectionResult >> asHandRayIntersection: actionState hand: aHand [

	^ SRHandRayIntersectionResult new
		object: self object;
		point: self point;
		actionState: actionState;
		hand: aHand
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

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 8/4/2026 11:07'
}
SRRayIntersectionResult >> printOn: aStream [

	super printOn: aStream.
	
	aStream nextPut: $(.
	self object printOn: aStream.
	aStream nextPutAll: ', '.
	self point printOn: aStream.
	aStream nextPut: $).
]
