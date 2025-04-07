Class {
	#name : #XrEventDataBaseHeader,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{ #category : #'as yet unclassified' }
XrEventDataBaseHeader class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
	)
]
