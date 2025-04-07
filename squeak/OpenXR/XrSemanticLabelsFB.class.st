Class {
	#name : #XrSemanticLabelsFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{ #category : #'as yet unclassified' }
XrSemanticLabelsFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(bufferCapacityInput 'uint32_t')
		(bufferCountOutput 'uint32_t')
		(buffer 'char*')
	)
]
