Class {
	#name : #XrEventDataSpaceEraseCompleteFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{ #category : #'as yet unclassified' }
XrEventDataSpaceEraseCompleteFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(requestId 'XrAsyncRequestIdFB')
		(result 'XrResult')
		(space 'XrSpace')
		(uuid 'XrUuidEXT')
		(location 'XrSpaceStorageLocationFB')
	)
]
