Class {
	#name : #XrCompositionLayerCylinderKHR,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{ #category : #'as yet unclassified' }
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
