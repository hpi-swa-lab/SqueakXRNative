Class {
	#name : #XrSwapchainImageWaitInfo,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{ #category : #'as yet unclassified' }
XrSwapchainImageWaitInfo class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(timeout 'XrDuration')
	)
]
