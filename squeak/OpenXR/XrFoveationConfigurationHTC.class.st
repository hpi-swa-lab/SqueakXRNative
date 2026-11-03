Class {
	#name : #XrFoveationConfigurationHTC,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrFoveationConfigurationHTC class >> fields [

	^ #(
		(level 'XrFoveationLevelHTC')
		(clearFovDegree 'float')
		(focalCenterOffset 'XrVector2f')
	)
]
