Class {
	#name : #XrEnvironmentDepthSwapchainStateMETA,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrEnvironmentDepthSwapchainStateMETA class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(width 'uint32_t')
		(height 'uint32_t')
	)
]
