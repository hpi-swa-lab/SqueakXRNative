Class {
	#name : #XrScenePlaneAlignmentFilterInfoMSFT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrScenePlaneAlignmentFilterInfoMSFT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(alignmentCount 'uint32_t')
		(alignments 'XrScenePlaneAlignmentTypeMSFT*')
	)
]
