Class {
	#name : #XrSerializedSceneFragmentDataGetInfoMSFT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{ #category : #'as yet unclassified' }
XrSerializedSceneFragmentDataGetInfoMSFT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(sceneFragmentId 'XrUuidMSFT')
	)
]
