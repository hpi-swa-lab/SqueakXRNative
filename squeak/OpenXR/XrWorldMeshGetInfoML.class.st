Class {
	#name : #XrWorldMeshGetInfoML,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-6-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrWorldMeshGetInfoML class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(flags 'XrWorldMeshDetectorFlagsML')
		(fillHoleLength 'float')
		(disconnectedComponentArea 'float')
		(blockCount 'uint32_t')
		(blocks 'XrWorldMeshBlockRequestML*')
	)
]
