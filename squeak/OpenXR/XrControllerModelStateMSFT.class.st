Class {
	#name : #XrControllerModelStateMSFT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{ #category : #'as yet unclassified' }
XrControllerModelStateMSFT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(nodeCapacityInput 'uint32_t')
		(nodeCountOutput 'uint32_t')
		(nodeStates 'XrControllerModelNodeStateMSFT*')
	)
]
