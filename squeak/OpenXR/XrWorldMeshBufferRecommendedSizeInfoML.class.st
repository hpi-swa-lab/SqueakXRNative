Class {
	#name : #XrWorldMeshBufferRecommendedSizeInfoML,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-6-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrWorldMeshBufferRecommendedSizeInfoML class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(maxBlockCount 'uint32_t')
	)
]
