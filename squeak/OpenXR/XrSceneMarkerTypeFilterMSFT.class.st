Class {
	#name : #XrSceneMarkerTypeFilterMSFT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{ #category : #'as yet unclassified' }
XrSceneMarkerTypeFilterMSFT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(markerTypeCount 'uint32_t')
		(markerTypes 'XrSceneMarkerTypeMSFT*')
	)
]
