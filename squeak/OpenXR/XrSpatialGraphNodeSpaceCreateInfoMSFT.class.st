Class {
	#name : #XrSpatialGraphNodeSpaceCreateInfoMSFT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{ #category : #'as yet unclassified' }
XrSpatialGraphNodeSpaceCreateInfoMSFT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(nodeType 'XrSpatialGraphNodeTypeMSFT')
		(nodeId 'uint8_t[16]')
		(pose 'XrPosef')
	)
]
