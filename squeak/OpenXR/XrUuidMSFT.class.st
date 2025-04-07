Class {
	#name : #XrUuidMSFT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{ #category : #'as yet unclassified' }
XrUuidMSFT class >> fields [

	^ #(
		(bytes 'uint8_t[16]')
	)
]
