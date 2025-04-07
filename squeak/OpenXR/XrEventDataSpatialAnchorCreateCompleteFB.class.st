Class {
	#name : #XrEventDataSpatialAnchorCreateCompleteFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{ #category : #'as yet unclassified' }
XrEventDataSpatialAnchorCreateCompleteFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(requestId 'XrAsyncRequestIdFB')
		(result 'XrResult')
		(space 'XrSpace')
		(uuid 'XrUuidEXT')
	)
]
