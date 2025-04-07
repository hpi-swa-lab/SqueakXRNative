Class {
	#name : #XrSystemFaceTrackingPropertiesFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{ #category : #'as yet unclassified' }
XrSystemFaceTrackingPropertiesFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(supportsFaceTracking 'XrBool32')
	)
]
