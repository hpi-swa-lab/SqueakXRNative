Class {
	#name : #XrScenePlaneMSFT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrScenePlaneMSFT class >> fields [

	^ #(
		(alignment 'XrScenePlaneAlignmentTypeMSFT')
		(size 'XrExtent2Df')
		(meshBufferId 'uint64_t')
		(supportsIndicesUint16 'XrBool32')
	)
]
