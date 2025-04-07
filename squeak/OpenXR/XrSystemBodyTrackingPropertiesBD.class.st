Class {
	#name : #XrSystemBodyTrackingPropertiesBD,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrSystemBodyTrackingPropertiesBD class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(supportsBodyTracking 'XrBool32')
	)
]
