Class {
	#name : #XrSpatialAnchorsDeleteInfoML,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-6-Generated'
}

{ #category : #'as yet unclassified' }
XrSpatialAnchorsDeleteInfoML class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(uuidCount 'uint32_t')
		(uuids 'XrUuidEXT*')
	)
]
