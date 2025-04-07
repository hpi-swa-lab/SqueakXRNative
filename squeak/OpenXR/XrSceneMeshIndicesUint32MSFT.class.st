Class {
	#name : #XrSceneMeshIndicesUint32MSFT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{ #category : #'as yet unclassified' }
XrSceneMeshIndicesUint32MSFT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(indexCapacityInput 'uint32_t')
		(indexCountOutput 'uint32_t')
		(indices 'uint32_t*')
	)
]
