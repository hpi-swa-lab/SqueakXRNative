Class {
	#name : #XrVulkanGraphicsDeviceGetInfoKHR,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{ #category : #'as yet unclassified' }
XrVulkanGraphicsDeviceGetInfoKHR class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(systemId 'XrSystemId')
		(vulkanInstance 'void')
	)
]
