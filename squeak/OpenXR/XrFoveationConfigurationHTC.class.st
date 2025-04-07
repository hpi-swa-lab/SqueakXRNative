Class {
	#name : #XrFoveationConfigurationHTC,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrFoveationConfigurationHTC class >> fields [

	^ #(
		(level 'XrFoveationLevelHTC')
		(clearFovDegree 'float')
		(focalCenterOffset 'XrVector2f')
	)
]
