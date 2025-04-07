Class {
	#name : #XrEnvironmentDepthSwapchainStateMETA,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{ #category : #'as yet unclassified' }
XrEnvironmentDepthSwapchainStateMETA class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(width 'uint32_t')
		(height 'uint32_t')
	)
]
