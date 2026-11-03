Class {
	#name : #XrGraphicsRequirementsOpenGLKHR,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrGraphicsRequirementsOpenGLKHR class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(minApiVersionSupported 'XrVersion')
		(maxApiVersionSupported 'XrVersion')
	)
]
