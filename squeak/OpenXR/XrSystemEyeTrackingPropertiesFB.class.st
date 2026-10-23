Class {
	#name : #XrSystemEyeTrackingPropertiesFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrSystemEyeTrackingPropertiesFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(supportsEyeTracking 'XrBool32')
	)
]
