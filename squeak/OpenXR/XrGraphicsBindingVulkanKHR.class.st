Class {
	#name : #XrGraphicsBindingVulkanKHR,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrGraphicsBindingVulkanKHR class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(instance 'void')
		(physicalDevice 'void')
		(device 'void')
		(queueFamilyIndex 'uint32_t')
		(queueIndex 'uint32_t')
	)
]
