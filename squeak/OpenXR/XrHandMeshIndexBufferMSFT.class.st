Class {
	#name : #XrHandMeshIndexBufferMSFT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{ #category : #'as yet unclassified' }
XrHandMeshIndexBufferMSFT class >> fields [

	^ #(
		(indexBufferKey 'uint32_t')
		(indexCapacityInput 'uint32_t')
		(indexCountOutput 'uint32_t')
		(indices 'uint32_t*')
	)
]
