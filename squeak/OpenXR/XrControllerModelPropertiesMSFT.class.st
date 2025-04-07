Class {
	#name : #XrControllerModelPropertiesMSFT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{ #category : #'as yet unclassified' }
XrControllerModelPropertiesMSFT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(nodeCapacityInput 'uint32_t')
		(nodeCountOutput 'uint32_t')
		(nodeProperties 'XrControllerModelNodePropertiesMSFT*')
	)
]
