Class {
	#name : #XrWorldMeshRequestCompletionML,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-6-Generated'
}

{ #category : #'as yet unclassified' }
XrWorldMeshRequestCompletionML class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(futureResult 'XrResult')
		(blockCount 'uint32_t')
		(blocks 'XrWorldMeshBlockML*')
	)
]
