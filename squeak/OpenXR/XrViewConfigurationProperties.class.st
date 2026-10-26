Class {
	#name : #XrViewConfigurationProperties,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrViewConfigurationProperties class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(viewConfigurationType 'XrViewConfigurationType')
		(fovMutable 'XrBool32')
	)
]
