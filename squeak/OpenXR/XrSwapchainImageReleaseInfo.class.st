Class {
	#name : #XrSwapchainImageReleaseInfo,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{ #category : #'as yet unclassified' }
XrSwapchainImageReleaseInfo class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
	)
]
