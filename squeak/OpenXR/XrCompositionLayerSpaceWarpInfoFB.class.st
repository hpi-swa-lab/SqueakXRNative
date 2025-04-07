Class {
	#name : #XrCompositionLayerSpaceWarpInfoFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrCompositionLayerSpaceWarpInfoFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(layerFlags 'XrCompositionLayerSpaceWarpInfoFlagsFB')
		(motionVectorSubImage 'XrSwapchainSubImage')
		(appSpaceDeltaPose 'XrPosef')
		(depthSubImage 'XrSwapchainSubImage')
		(minDepth 'float')
		(maxDepth 'float')
		(nearZ 'float')
		(farZ 'float')
	)
]
