Class {
	#name : #XrSystemPlaneDetectionPropertiesEXT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{ #category : #'as yet unclassified' }
XrSystemPlaneDetectionPropertiesEXT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(supportedFeatures 'XrPlaneDetectionCapabilityFlagsEXT')
	)
]
