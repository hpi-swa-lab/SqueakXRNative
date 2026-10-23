Class {
	#name : #XrHandMeshVertexBufferMSFT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrHandMeshVertexBufferMSFT class >> fields [

	^ #(
		(vertexUpdateTime 'XrTime')
		(vertexCapacityInput 'uint32_t')
		(vertexCountOutput 'uint32_t')
		(vertices 'XrHandMeshVertexMSFT*')
	)
]
