Class {
	#name : #XrSpatialAnchorsCreateInfoFromUuidsML,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{ #category : #'as yet unclassified' }
XrSpatialAnchorsCreateInfoFromUuidsML class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(storage 'XrSpatialAnchorsStorageML')
		(uuidCount 'uint32_t')
		(uuids 'XrUuidEXT*')
	)
]
