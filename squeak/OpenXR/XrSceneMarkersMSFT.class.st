Class {
	#name : #XrSceneMarkersMSFT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{ #category : #'as yet unclassified' }
XrSceneMarkersMSFT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(sceneMarkerCapacityInput 'uint32_t')
		(sceneMarkers 'XrSceneMarkerMSFT*')
	)
]
