Class {
	#name : #XrVulkanDeviceCreateInfoKHR,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrVulkanDeviceCreateInfoKHR class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(systemId 'XrSystemId')
		(createFlags 'XrVulkanDeviceCreateFlagsKHR')
		(pfnGetInstanceProcAddr 'void')
		(vulkanPhysicalDevice 'void')
		(vulkanCreateInfo 'void*')
		(vulkanAllocator 'void*')
	)
]
