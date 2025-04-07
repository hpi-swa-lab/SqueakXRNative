Class {
	#name : #XrSwapchainStateBaseHeaderFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{ #category : #'as yet unclassified' }
XrSwapchainStateBaseHeaderFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
	)
]
