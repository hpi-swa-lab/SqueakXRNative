Class {
	#name : #XrVulkanSwapchainCreateInfoMETA,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{ #category : #'as yet unclassified' }
XrVulkanSwapchainCreateInfoMETA class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(additionalCreateFlags 'void')
		(additionalUsageFlags 'void')
	)
]
