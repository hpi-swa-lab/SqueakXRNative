Class {
	#name : #XrSwapchainStateBaseHeaderFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrSwapchainStateBaseHeaderFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
	)
]
