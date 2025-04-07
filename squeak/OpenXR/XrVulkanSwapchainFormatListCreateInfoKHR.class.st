Class {
	#name : #XrVulkanSwapchainFormatListCreateInfoKHR,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{ #category : #'as yet unclassified' }
XrVulkanSwapchainFormatListCreateInfoKHR class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(viewFormatCount 'uint32_t')
		(viewFormats 'void*')
	)
]
