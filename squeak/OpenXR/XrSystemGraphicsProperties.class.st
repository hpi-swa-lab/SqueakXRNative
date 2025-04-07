Class {
	#name : #XrSystemGraphicsProperties,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{ #category : #'as yet unclassified' }
XrSystemGraphicsProperties class >> fields [

	^ #(
		(maxSwapchainImageHeight 'uint32_t')
		(maxSwapchainImageWidth 'uint32_t')
		(maxLayerCount 'uint32_t')
	)
]
