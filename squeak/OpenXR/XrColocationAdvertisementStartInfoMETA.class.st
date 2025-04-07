Class {
	#name : #XrColocationAdvertisementStartInfoMETA,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrColocationAdvertisementStartInfoMETA class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(bufferSize 'uint32_t')
		(buffer 'uint8_t*')
	)
]
