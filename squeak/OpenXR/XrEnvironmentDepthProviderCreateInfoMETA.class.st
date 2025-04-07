Class {
	#name : #XrEnvironmentDepthProviderCreateInfoMETA,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{ #category : #'as yet unclassified' }
XrEnvironmentDepthProviderCreateInfoMETA class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(createFlags 'XrEnvironmentDepthProviderCreateFlagsMETA')
	)
]
