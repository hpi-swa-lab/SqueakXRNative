Class {
	#name : #XrCreateSpatialAnchorsCompletionML,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{ #category : #'as yet unclassified' }
XrCreateSpatialAnchorsCompletionML class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(futureResult 'XrResult')
		(spaceCount 'uint32_t')
		(spaces 'XrSpace*')
	)
]
