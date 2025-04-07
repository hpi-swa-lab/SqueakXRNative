Class {
	#name : #XrSystemBodyTrackingPropertiesHTC,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrSystemBodyTrackingPropertiesHTC class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(supportsBodyTracking 'XrBool32')
	)
]
