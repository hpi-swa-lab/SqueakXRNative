Class {
	#name : #XrSystemFaceTrackingProperties2FB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrSystemFaceTrackingProperties2FB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(supportsVisualFaceTracking 'XrBool32')
		(supportsAudioFaceTracking 'XrBool32')
	)
]
