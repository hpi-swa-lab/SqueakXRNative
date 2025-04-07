Class {
	#name : #XrGraphicsRequirementsOpenGLKHR,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{ #category : #'as yet unclassified' }
XrGraphicsRequirementsOpenGLKHR class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(minApiVersionSupported 'XrVersion')
		(maxApiVersionSupported 'XrVersion')
	)
]
