Class {
	#name : #XrSpatialAnchorsPublishCompletionML,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-6-Generated'
}

{ #category : #'as yet unclassified' }
XrSpatialAnchorsPublishCompletionML class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(futureResult 'XrResult')
		(uuidCount 'uint32_t')
		(uuids 'XrUuidEXT*')
	)
]
