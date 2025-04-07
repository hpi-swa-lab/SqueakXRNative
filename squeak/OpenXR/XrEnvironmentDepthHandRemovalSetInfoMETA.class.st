Class {
	#name : #XrEnvironmentDepthHandRemovalSetInfoMETA,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{ #category : #'as yet unclassified' }
XrEnvironmentDepthHandRemovalSetInfoMETA class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(enabled 'XrBool32')
	)
]
