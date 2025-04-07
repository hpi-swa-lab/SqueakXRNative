Class {
	#name : #XrSceneMarkerMSFT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{ #category : #'as yet unclassified' }
XrSceneMarkerMSFT class >> fields [

	^ #(
		(markerType 'XrSceneMarkerTypeMSFT')
		(lastSeenTime 'XrTime')
		(center 'XrOffset2Df')
		(size 'XrExtent2Df')
	)
]
