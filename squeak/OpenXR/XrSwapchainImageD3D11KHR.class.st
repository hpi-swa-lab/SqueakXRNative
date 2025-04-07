Class {
	#name : #XrSwapchainImageD3D11KHR,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{ #category : #'as yet unclassified' }
XrSwapchainImageD3D11KHR class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(texture 'void*')
	)
]
