Class {
	#name : #XrSceneComponentLocationsMSFT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{ #category : #'as yet unclassified' }
XrSceneComponentLocationsMSFT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(locationCount 'uint32_t')
		(locations 'XrSceneComponentLocationMSFT*')
	)
]
