Class {
	#name : #XrWorldMeshBufferML,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-6-Generated'
}

{ #category : #'as yet unclassified' }
XrWorldMeshBufferML class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(bufferSize 'uint32_t')
		(buffer 'void*')
	)
]
