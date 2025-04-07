Class {
	#name : #XrSystemHandTrackingPropertiesEXT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{ #category : #'as yet unclassified' }
XrSystemHandTrackingPropertiesEXT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(supportsHandTracking 'XrBool32')
	)
]
