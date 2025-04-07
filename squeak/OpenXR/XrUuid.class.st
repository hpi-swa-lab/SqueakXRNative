Class {
	#name : #XrUuid,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{ #category : #'as yet unclassified' }
XrUuid class >> fields [

	^ #(
		(data 'uint8_t[16]')
	)
]
