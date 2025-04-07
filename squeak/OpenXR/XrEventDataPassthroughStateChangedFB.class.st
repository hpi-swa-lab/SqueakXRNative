Class {
	#name : #XrEventDataPassthroughStateChangedFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrEventDataPassthroughStateChangedFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(flags 'XrPassthroughStateChangedFlagsFB')
	)
]
