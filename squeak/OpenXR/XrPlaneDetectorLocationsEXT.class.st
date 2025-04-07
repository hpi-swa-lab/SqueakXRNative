Class {
	#name : #XrPlaneDetectorLocationsEXT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{ #category : #'as yet unclassified' }
XrPlaneDetectorLocationsEXT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(planeLocationCapacityInput 'uint32_t')
		(planeLocationCountOutput 'uint32_t')
		(planeLocations 'XrPlaneDetectorLocationEXT*')
	)
]
