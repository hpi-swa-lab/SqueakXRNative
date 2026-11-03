Class {
	#name : #XrVulkanSwapchainFormatListCreateInfoKHR,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrVulkanSwapchainFormatListCreateInfoKHR class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(viewFormatCount 'uint32_t')
		(viewFormats 'void*')
	)
]
