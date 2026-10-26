Class {
	#name : #XrCompositionLayerCylinderKHR,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrCompositionLayerCylinderKHR class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(layerFlags 'XrCompositionLayerFlags')
		(space 'XrSpace')
		(eyeVisibility 'XrEyeVisibility')
		(subImage 'XrSwapchainSubImage')
		(pose 'XrPosef')
		(radius 'float')
		(centralAngle 'float')
		(aspectRatio 'float')
	)
]
