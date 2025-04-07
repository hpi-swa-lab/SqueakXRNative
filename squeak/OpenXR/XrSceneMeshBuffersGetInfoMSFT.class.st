Class {
	#name : #XrSceneMeshBuffersGetInfoMSFT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{ #category : #'as yet unclassified' }
XrSceneMeshBuffersGetInfoMSFT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(meshBufferId 'uint64_t')
	)
]
