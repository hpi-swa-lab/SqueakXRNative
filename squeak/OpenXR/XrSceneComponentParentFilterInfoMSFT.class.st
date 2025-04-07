Class {
	#name : #XrSceneComponentParentFilterInfoMSFT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{ #category : #'as yet unclassified' }
XrSceneComponentParentFilterInfoMSFT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(parentId 'XrUuidMSFT')
	)
]
