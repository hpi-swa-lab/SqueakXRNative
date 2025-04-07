Class {
	#name : #XrActiveActionSet,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{ #category : #'as yet unclassified' }
XrActiveActionSet class >> fields [

	^ #(
		(actionSet 'XrActionSet')
		(subactionPath 'XrPath')
	)
]
