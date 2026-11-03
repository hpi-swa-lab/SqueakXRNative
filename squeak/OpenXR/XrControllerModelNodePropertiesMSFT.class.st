Class {
	#name : #XrControllerModelNodePropertiesMSFT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrControllerModelNodePropertiesMSFT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(parentNodeName 'char[64]')
		(nodeName 'char[64]')
	)
]
