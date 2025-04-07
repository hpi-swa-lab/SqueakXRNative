Class {
	#name : #XrSwapchainImageVulkanKHR,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{ #category : #'as yet unclassified' }
XrSwapchainImageVulkanKHR class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(image 'void')
	)
]
