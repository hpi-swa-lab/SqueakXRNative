Class {
	#name : #XrDeserializeSceneFragmentMSFT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{ #category : #'as yet unclassified' }
XrDeserializeSceneFragmentMSFT class >> fields [

	^ #(
		(bufferSize 'uint32_t')
		(buffer 'uint8_t*')
	)
]
