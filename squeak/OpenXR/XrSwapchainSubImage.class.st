Class {
	#name : #XrSwapchainSubImage,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{ #category : #'as yet unclassified' }
XrSwapchainSubImage class >> fields [

	^ #(
		(swapchain 'XrSwapchain')
		(imageRect 'XrRect2Di')
		(imageArrayIndex 'uint32_t')
	)
]
