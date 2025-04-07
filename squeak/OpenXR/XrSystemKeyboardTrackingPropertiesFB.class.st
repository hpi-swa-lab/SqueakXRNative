Class {
	#name : #XrSystemKeyboardTrackingPropertiesFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{ #category : #'as yet unclassified' }
XrSystemKeyboardTrackingPropertiesFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(supportsKeyboardTracking 'XrBool32')
	)
]
