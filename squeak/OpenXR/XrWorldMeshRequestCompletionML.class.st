Class {
	#name : #XrWorldMeshRequestCompletionML,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-6-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrWorldMeshRequestCompletionML class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(futureResult 'XrResult')
		(blockCount 'uint32_t')
		(blocks 'XrWorldMeshBlockML*')
	)
]
