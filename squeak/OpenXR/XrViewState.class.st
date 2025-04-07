Class {
	#name : #XrViewState,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{ #category : #'as yet unclassified' }
XrViewState class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(viewStateFlags 'XrViewStateFlags')
	)
]
