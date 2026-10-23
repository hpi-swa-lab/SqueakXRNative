Class {
	#name : #XrSwapchainImageD3D11KHR,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrSwapchainImageD3D11KHR class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(texture 'void*')
	)
]
