Class {
	#name : #XrSwapchainImageD3D12KHR,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{ #category : #'as yet unclassified' }
XrSwapchainImageD3D12KHR class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(texture 'void*')
	)
]
