Class {
	#name : #XrHandMeshVertexBufferMSFT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{ #category : #'as yet unclassified' }
XrHandMeshVertexBufferMSFT class >> fields [

	^ #(
		(vertexUpdateTime 'XrTime')
		(vertexCapacityInput 'uint32_t')
		(vertexCountOutput 'uint32_t')
		(vertices 'XrHandMeshVertexMSFT*')
	)
]
