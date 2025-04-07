Class {
	#name : #XrSwapchainImageFoveationVulkanFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{ #category : #'as yet unclassified' }
XrSwapchainImageFoveationVulkanFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(image 'void')
		(width 'uint32_t')
		(height 'uint32_t')
	)
]
