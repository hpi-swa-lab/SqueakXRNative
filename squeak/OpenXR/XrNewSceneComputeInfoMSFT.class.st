Class {
	#name : #XrNewSceneComputeInfoMSFT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{ #category : #'as yet unclassified' }
XrNewSceneComputeInfoMSFT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(requestedFeatureCount 'uint32_t')
		(requestedFeatures 'XrSceneComputeFeatureMSFT*')
		(consistency 'XrSceneComputeConsistencyMSFT')
		(bounds 'XrSceneBoundsMSFT')
	)
]
