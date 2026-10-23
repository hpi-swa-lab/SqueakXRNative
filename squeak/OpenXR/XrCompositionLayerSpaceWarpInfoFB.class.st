Class {
	#name : #XrCompositionLayerSpaceWarpInfoFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
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
