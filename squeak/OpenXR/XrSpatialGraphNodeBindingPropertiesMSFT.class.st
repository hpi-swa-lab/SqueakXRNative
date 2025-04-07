Class {
	#name : #XrSpatialGraphNodeBindingPropertiesMSFT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{ #category : #'as yet unclassified' }
XrSpatialGraphNodeBindingPropertiesMSFT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(nodeId 'uint8_t[16]')
		(poseInNodeSpace 'XrPosef')
	)
]
