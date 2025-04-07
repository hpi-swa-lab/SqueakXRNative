Class {
	#name : #XrSwapchainStateFoveationFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{ #category : #'as yet unclassified' }
XrSwapchainStateFoveationFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(flags 'XrSwapchainStateFoveationFlagsFB')
		(profile 'XrFoveationProfileFB')
	)
]
