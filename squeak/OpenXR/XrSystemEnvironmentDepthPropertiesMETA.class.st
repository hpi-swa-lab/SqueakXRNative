Class {
	#name : #XrSystemEnvironmentDepthPropertiesMETA,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{ #category : #'as yet unclassified' }
XrSystemEnvironmentDepthPropertiesMETA class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(supportsEnvironmentDepth 'XrBool32')
		(supportsHandRemoval 'XrBool32')
	)
]
