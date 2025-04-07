Class {
	#name : #XrControllerModelKeyStateMSFT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{ #category : #'as yet unclassified' }
XrControllerModelKeyStateMSFT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(modelKey 'XrControllerModelKeyMSFT')
	)
]
