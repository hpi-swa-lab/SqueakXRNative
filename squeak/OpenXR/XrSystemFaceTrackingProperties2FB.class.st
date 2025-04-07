Class {
	#name : #XrSystemFaceTrackingProperties2FB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{ #category : #'as yet unclassified' }
XrSystemFaceTrackingProperties2FB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(supportsVisualFaceTracking 'XrBool32')
		(supportsAudioFaceTracking 'XrBool32')
	)
]
