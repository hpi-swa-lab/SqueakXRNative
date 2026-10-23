Class {
	#name : #XrCompositionLayerEquirect2KHR,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrCompositionLayerEquirect2KHR class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(layerFlags 'XrCompositionLayerFlags')
		(space 'XrSpace')
		(eyeVisibility 'XrEyeVisibility')
		(subImage 'XrSwapchainSubImage')
		(pose 'XrPosef')
		(radius 'float')
		(centralHorizontalAngle 'float')
		(upperVerticalAngle 'float')
		(lowerVerticalAngle 'float')
	)
]
