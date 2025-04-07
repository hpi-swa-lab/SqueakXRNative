Class {
	#name : #XrEventDataSpaceSaveCompleteFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{ #category : #'as yet unclassified' }
XrEventDataSpaceSaveCompleteFB class >> fields [

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
