Class {
	#name : #XrSpatialGraphNodeSpaceCreateInfoMSFT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrSpatialGraphNodeSpaceCreateInfoMSFT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(nodeType 'XrSpatialGraphNodeTypeMSFT')
		(nodeId 'uint8_t[16]')
		(pose 'XrPosef')
	)
]
