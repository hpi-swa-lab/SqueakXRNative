Class {
	#name : #XrHandMeshMSFT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{ #category : #'as yet unclassified' }
XrHandMeshMSFT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(isActive 'XrBool32')
		(indexBufferChanged 'XrBool32')
		(vertexBufferChanged 'XrBool32')
		(indexBuffer 'XrHandMeshIndexBufferMSFT')
		(vertexBuffer 'XrHandMeshVertexBufferMSFT')
	)
]
