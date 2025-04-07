Class {
	#name : #XrSystemBodyTrackingPropertiesFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{ #category : #'as yet unclassified' }
XrSystemBodyTrackingPropertiesFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(supportsBodyTracking 'XrBool32')
	)
]
