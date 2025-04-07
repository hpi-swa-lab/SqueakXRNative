Class {
	#name : #XrSystemFacialTrackingPropertiesHTC,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrSystemFacialTrackingPropertiesHTC class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(supportEyeFacialTracking 'XrBool32')
		(supportLipFacialTracking 'XrBool32')
	)
]
