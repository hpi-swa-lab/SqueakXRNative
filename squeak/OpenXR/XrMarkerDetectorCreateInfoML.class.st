Class {
	#name : #XrMarkerDetectorCreateInfoML,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{ #category : #'as yet unclassified' }
XrMarkerDetectorCreateInfoML class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(profile 'XrMarkerDetectorProfileML')
		(markerType 'XrMarkerTypeML')
	)
]
