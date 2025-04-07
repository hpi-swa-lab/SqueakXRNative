Class {
	#name : #XrVulkanInstanceCreateInfoKHR,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{ #category : #'as yet unclassified' }
XrVulkanInstanceCreateInfoKHR class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(systemId 'XrSystemId')
		(createFlags 'XrVulkanInstanceCreateFlagsKHR')
		(pfnGetInstanceProcAddr 'void')
		(vulkanCreateInfo 'void*')
		(vulkanAllocator 'void*')
	)
]
