Class {
	#name : #XrVulkanDeviceCreateInfoKHR,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{ #category : #'as yet unclassified' }
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
