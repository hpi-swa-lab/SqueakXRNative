Class {
	#name : #XrSwapchainSubImage,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrSwapchainSubImage class >> fields [

	^ #(
		(swapchain 'XrSwapchain')
		(imageRect 'XrRect2Di')
		(imageArrayIndex 'uint32_t')
	)
]
