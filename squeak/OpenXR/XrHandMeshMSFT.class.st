Class {
	#name : #XrHandMeshMSFT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
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
