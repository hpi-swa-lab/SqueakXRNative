Class {
	#name : #XrScenePlaneMSFT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{ #category : #'as yet unclassified' }
XrScenePlaneMSFT class >> fields [

	^ #(
		(alignment 'XrScenePlaneAlignmentTypeMSFT')
		(size 'XrExtent2Df')
		(meshBufferId 'uint64_t')
		(supportsIndicesUint16 'XrBool32')
	)
]
