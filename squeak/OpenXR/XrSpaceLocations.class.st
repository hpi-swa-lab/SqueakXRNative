Class {
	#name : #XrSpaceLocations,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{ #category : #'as yet unclassified' }
XrSpaceLocations class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(locationCount 'uint32_t')
		(locations 'XrSpaceLocationData*')
	)
]
