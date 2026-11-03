Class {
	#name : #XrSceneComponentMSFT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrSceneComponentMSFT class >> fields [

	^ #(
		(componentType 'XrSceneComponentTypeMSFT')
		(id 'XrUuidMSFT')
		(parentId 'XrUuidMSFT')
		(updateTime 'XrTime')
	)
]
