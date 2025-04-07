Class {
	#name : #XrSceneDeserializeInfoMSFT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{ #category : #'as yet unclassified' }
XrSceneDeserializeInfoMSFT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(fragmentCount 'uint32_t')
		(fragments 'XrDeserializeSceneFragmentMSFT*')
	)
]
