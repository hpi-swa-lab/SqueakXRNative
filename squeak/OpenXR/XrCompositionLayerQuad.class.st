Class {
	#name : #XrCompositionLayerQuad,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{ #category : #'as yet unclassified' }
XrCompositionLayerQuad class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(layerFlags 'XrCompositionLayerFlags')
		(space 'XrSpace')
		(eyeVisibility 'XrEyeVisibility')
		(subImage 'XrSwapchainSubImage')
		(pose 'XrPosef')
		(size 'XrExtent2Df')
	)
]
