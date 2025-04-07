Class {
	#name : #XrSwapchainImageMetalKHR,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{ #category : #'as yet unclassified' }
XrSwapchainImageMetalKHR class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(texture 'void*')
	)
]
