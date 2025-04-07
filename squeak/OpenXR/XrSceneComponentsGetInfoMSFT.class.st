Class {
	#name : #XrSceneComponentsGetInfoMSFT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{ #category : #'as yet unclassified' }
XrSceneComponentsGetInfoMSFT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(componentType 'XrSceneComponentTypeMSFT')
	)
]
