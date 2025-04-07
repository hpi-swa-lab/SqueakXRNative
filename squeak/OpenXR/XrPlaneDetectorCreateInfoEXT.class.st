Class {
	#name : #XrPlaneDetectorCreateInfoEXT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{ #category : #'as yet unclassified' }
XrPlaneDetectorCreateInfoEXT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(flags 'XrPlaneDetectorFlagsEXT')
	)
]
