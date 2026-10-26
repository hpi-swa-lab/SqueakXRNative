Class {
	#name : #XrSystemGraphicsProperties,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrSystemGraphicsProperties class >> fields [

	^ #(
		(maxSwapchainImageHeight 'uint32_t')
		(maxSwapchainImageWidth 'uint32_t')
		(maxLayerCount 'uint32_t')
	)
]
