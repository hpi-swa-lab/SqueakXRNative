Class {
	#name : #XrSpaceUuidFilterInfoFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{ #category : #'as yet unclassified' }
XrSpaceUuidFilterInfoFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(uuidCount 'uint32_t')
		(uuids 'XrUuidEXT*')
	)
]
