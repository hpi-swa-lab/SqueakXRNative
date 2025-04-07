Class {
	#name : #XrBoundary2DFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{ #category : #'as yet unclassified' }
XrBoundary2DFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(vertexCapacityInput 'uint32_t')
		(vertexCountOutput 'uint32_t')
		(vertices 'XrVector2f*')
	)
]
