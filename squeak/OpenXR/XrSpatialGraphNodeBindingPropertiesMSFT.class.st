Class {
	#name : #XrSpatialGraphNodeBindingPropertiesMSFT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrSpatialGraphNodeBindingPropertiesMSFT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(nodeId 'uint8_t[16]')
		(poseInNodeSpace 'XrPosef')
	)
]
