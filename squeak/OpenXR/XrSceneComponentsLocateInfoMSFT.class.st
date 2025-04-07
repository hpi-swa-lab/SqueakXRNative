Class {
	#name : #XrSceneComponentsLocateInfoMSFT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{ #category : #'as yet unclassified' }
XrSceneComponentsLocateInfoMSFT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(baseSpace 'XrSpace')
		(time 'XrTime')
		(componentIdCount 'uint32_t')
		(componentIds 'XrUuidMSFT*')
	)
]
