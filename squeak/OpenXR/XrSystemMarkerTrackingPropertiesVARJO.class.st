Class {
	#name : #XrSystemMarkerTrackingPropertiesVARJO,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrSystemMarkerTrackingPropertiesVARJO class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(supportsMarkerTracking 'XrBool32')
	)
]
