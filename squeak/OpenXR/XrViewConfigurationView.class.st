Class {
	#name : #XrViewConfigurationView,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{ #category : #'as yet unclassified' }
XrViewConfigurationView class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(recommendedImageRectWidth 'uint32_t')
		(maxImageRectWidth 'uint32_t')
		(recommendedImageRectHeight 'uint32_t')
		(maxImageRectHeight 'uint32_t')
		(recommendedSwapchainSampleCount 'uint32_t')
		(maxSwapchainSampleCount 'uint32_t')
	)
]
