Class {
	#name : #XrHapticBaseHeader,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{ #category : #'as yet unclassified' }
XrHapticBaseHeader class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
	)
]
