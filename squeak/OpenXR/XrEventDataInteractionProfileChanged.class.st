Class {
	#name : #XrEventDataInteractionProfileChanged,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{ #category : #'as yet unclassified' }
XrEventDataInteractionProfileChanged class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(session 'XrSession')
	)
]
