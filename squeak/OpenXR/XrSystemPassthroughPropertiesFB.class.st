Class {
	#name : #XrSystemPassthroughPropertiesFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrSystemPassthroughPropertiesFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(supportsPassthrough 'XrBool32')
	)
]
