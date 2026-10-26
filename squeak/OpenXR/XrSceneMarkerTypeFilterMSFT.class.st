Class {
	#name : #XrSceneMarkerTypeFilterMSFT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrSceneMarkerTypeFilterMSFT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(markerTypeCount 'uint32_t')
		(markerTypes 'XrSceneMarkerTypeMSFT*')
	)
]
