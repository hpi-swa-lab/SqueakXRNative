Class {
	#name : #XrWorldMeshBufferRecommendedSizeInfoML,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-6-Generated'
}

{ #category : #'as yet unclassified' }
XrWorldMeshBufferRecommendedSizeInfoML class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(maxBlockCount 'uint32_t')
	)
]
