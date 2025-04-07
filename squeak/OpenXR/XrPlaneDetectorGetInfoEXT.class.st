Class {
	#name : #XrPlaneDetectorGetInfoEXT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{ #category : #'as yet unclassified' }
XrPlaneDetectorGetInfoEXT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(baseSpace 'XrSpace')
		(time 'XrTime')
	)
]
