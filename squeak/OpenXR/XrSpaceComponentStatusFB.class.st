Class {
	#name : #XrSpaceComponentStatusFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{ #category : #'as yet unclassified' }
XrSpaceComponentStatusFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(enabled 'XrBool32')
		(changePending 'XrBool32')
	)
]
