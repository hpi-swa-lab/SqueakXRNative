Class {
	#name : #XrSystemFacialTrackingPropertiesHTC,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrSystemFacialTrackingPropertiesHTC class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(supportEyeFacialTracking 'XrBool32')
		(supportLipFacialTracking 'XrBool32')
	)
]
