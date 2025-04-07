Class {
	#name : #XrSceneMeshMSFT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{ #category : #'as yet unclassified' }
XrSceneMeshMSFT class >> fields [

	^ #(
		(meshBufferId 'uint64_t')
		(supportsIndicesUint16 'XrBool32')
	)
]
