Class {
	#name : #XrCompositionLayerCubeKHR,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrCompositionLayerCubeKHR class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(layerFlags 'XrCompositionLayerFlags')
		(space 'XrSpace')
		(eyeVisibility 'XrEyeVisibility')
		(swapchain 'XrSwapchain')
		(imageArrayIndex 'uint32_t')
		(orientation 'XrQuaternionf')
	)
]
