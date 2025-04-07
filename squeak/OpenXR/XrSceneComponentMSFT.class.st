Class {
	#name : #XrSceneComponentMSFT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{ #category : #'as yet unclassified' }
XrSceneComponentMSFT class >> fields [

	^ #(
		(componentType 'XrSceneComponentTypeMSFT')
		(id 'XrUuidMSFT')
		(parentId 'XrUuidMSFT')
		(updateTime 'XrTime')
	)
]
