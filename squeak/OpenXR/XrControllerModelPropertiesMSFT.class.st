Class {
	#name : #XrControllerModelPropertiesMSFT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrControllerModelPropertiesMSFT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(nodeCapacityInput 'uint32_t')
		(nodeCountOutput 'uint32_t')
		(nodeProperties 'XrControllerModelNodePropertiesMSFT*')
	)
]
