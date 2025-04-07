Class {
	#name : #XrGraphicsRequirementsOpenGLESKHR,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{ #category : #'as yet unclassified' }
XrGraphicsRequirementsOpenGLESKHR class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(minApiVersionSupported 'XrVersion')
		(maxApiVersionSupported 'XrVersion')
	)
]
