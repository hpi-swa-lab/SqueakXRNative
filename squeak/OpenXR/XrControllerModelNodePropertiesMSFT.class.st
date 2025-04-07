Class {
	#name : #XrControllerModelNodePropertiesMSFT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{ #category : #'as yet unclassified' }
XrControllerModelNodePropertiesMSFT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(parentNodeName 'char[64]')
		(nodeName 'char[64]')
	)
]
