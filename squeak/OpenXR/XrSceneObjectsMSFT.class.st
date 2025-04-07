Class {
	#name : #XrSceneObjectsMSFT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{ #category : #'as yet unclassified' }
XrSceneObjectsMSFT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(sceneObjectCount 'uint32_t')
		(sceneObjects 'XrSceneObjectMSFT*')
	)
]
