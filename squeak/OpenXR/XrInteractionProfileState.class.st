Class {
	#name : #XrInteractionProfileState,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{ #category : #'as yet unclassified' }
XrInteractionProfileState class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(interactionProfile 'XrPath')
	)
]
