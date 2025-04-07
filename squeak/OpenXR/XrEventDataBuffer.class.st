Class {
	#name : #XrEventDataBuffer,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{ #category : #'as yet unclassified' }
XrEventDataBuffer class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(varying 'uint8_t[4000]')
	)
]
