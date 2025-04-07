Class {
	#name : #XrPassthroughColorLutDataMETA,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrPassthroughColorLutDataMETA class >> fields [

	^ #(
		(bufferSize 'uint32_t')
		(buffer 'uint8_t*')
	)
]
