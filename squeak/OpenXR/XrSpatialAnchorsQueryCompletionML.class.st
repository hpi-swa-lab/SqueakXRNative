Class {
	#name : #XrSpatialAnchorsQueryCompletionML,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{ #category : #'as yet unclassified' }
XrSpatialAnchorsQueryCompletionML class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(futureResult 'XrResult')
		(uuidCapacityInput 'uint32_t')
		(uuidCountOutput 'uint32_t')
		(uuids 'XrUuidEXT*')
	)
]
