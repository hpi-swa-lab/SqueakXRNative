Class {
	#name : #XrCompositionLayerEquirectKHR,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{ #category : #'as yet unclassified' }
XrCompositionLayerEquirectKHR class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(layerFlags 'XrCompositionLayerFlags')
		(space 'XrSpace')
		(eyeVisibility 'XrEyeVisibility')
		(subImage 'XrSwapchainSubImage')
		(pose 'XrPosef')
		(radius 'float')
		(scale 'XrVector2f')
		(bias 'XrVector2f')
	)
]
