Class {
	#name : #XrScenePlaneAlignmentFilterInfoMSFT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{ #category : #'as yet unclassified' }
XrScenePlaneAlignmentFilterInfoMSFT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(alignmentCount 'uint32_t')
		(alignments 'XrScenePlaneAlignmentTypeMSFT*')
	)
]
