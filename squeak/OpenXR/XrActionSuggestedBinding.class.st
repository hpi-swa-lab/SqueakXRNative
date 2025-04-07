Class {
	#name : #XrActionSuggestedBinding,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{ #category : #'as yet unclassified' }
XrActionSuggestedBinding class >> fields [

	^ #(
		(action 'XrAction')
		(binding 'XrPath')
	)
]
