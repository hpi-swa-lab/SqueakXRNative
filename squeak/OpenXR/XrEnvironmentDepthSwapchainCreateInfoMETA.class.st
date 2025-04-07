Class {
	#name : #XrEnvironmentDepthSwapchainCreateInfoMETA,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{ #category : #'as yet unclassified' }
XrEnvironmentDepthSwapchainCreateInfoMETA class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(createFlags 'XrEnvironmentDepthSwapchainCreateFlagsMETA')
	)
]
