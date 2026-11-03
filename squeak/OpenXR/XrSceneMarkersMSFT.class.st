Class {
	#name : #XrSceneMarkersMSFT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrSceneMarkersMSFT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(sceneMarkerCapacityInput 'uint32_t')
		(sceneMarkers 'XrSceneMarkerMSFT*')
	)
]
