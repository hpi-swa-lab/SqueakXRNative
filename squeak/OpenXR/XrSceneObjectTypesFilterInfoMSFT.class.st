Class {
	#name : #XrSceneObjectTypesFilterInfoMSFT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{ #category : #'as yet unclassified' }
XrSceneObjectTypesFilterInfoMSFT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(objectTypeCount 'uint32_t')
		(objectTypes 'XrSceneObjectTypeMSFT*')
	)
]
