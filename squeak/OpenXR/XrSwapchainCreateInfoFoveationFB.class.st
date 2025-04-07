Class {
	#name : #XrSwapchainCreateInfoFoveationFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{ #category : #'as yet unclassified' }
XrSwapchainCreateInfoFoveationFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(flags 'XrSwapchainCreateFoveationFlagsFB')
	)
]
