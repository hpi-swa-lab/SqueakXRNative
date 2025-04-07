Class {
	#name : #XrBaseInStructure,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{ #category : #'as yet unclassified' }
XrBaseInStructure class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'XrBaseInStructure*')
	)
]
