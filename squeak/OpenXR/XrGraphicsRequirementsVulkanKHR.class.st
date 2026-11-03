Class {
	#name : #XrGraphicsRequirementsVulkanKHR,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrGraphicsRequirementsVulkanKHR class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(minApiVersionSupported 'XrVersion')
		(maxApiVersionSupported 'XrVersion')
	)
]
