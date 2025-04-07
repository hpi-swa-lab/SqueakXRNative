Class {
	#name : #XrSystemEyeTrackingPropertiesFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{ #category : #'as yet unclassified' }
XrSystemEyeTrackingPropertiesFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(supportsEyeTracking 'XrBool32')
	)
]
