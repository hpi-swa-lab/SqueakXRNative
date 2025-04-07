Class {
	#name : #XrSwapchainImageBaseHeader,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{ #category : #'as yet unclassified' }
XrSwapchainImageBaseHeader class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
	)
]
