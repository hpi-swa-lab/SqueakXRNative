Class {
	#name : #XrSystemFoveationEyeTrackedPropertiesMETA,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{ #category : #'as yet unclassified' }
XrSystemFoveationEyeTrackedPropertiesMETA class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(supportsFoveationEyeTracked 'XrBool32')
	)
]
