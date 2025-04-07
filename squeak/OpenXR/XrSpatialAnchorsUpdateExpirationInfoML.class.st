Class {
	#name : #XrSpatialAnchorsUpdateExpirationInfoML,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-6-Generated'
}

{ #category : #'as yet unclassified' }
XrSpatialAnchorsUpdateExpirationInfoML class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(uuidCount 'uint32_t')
		(uuids 'XrUuidEXT*')
		(expiration 'uint64_t')
	)
]
