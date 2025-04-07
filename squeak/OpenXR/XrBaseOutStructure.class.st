Class {
	#name : #XrBaseOutStructure,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{ #category : #'as yet unclassified' }
XrBaseOutStructure class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'XrBaseOutStructure*')
	)
]
