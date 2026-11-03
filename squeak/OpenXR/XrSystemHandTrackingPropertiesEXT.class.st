Class {
	#name : #XrSystemHandTrackingPropertiesEXT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrSystemHandTrackingPropertiesEXT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(supportsHandTracking 'XrBool32')
	)
]
