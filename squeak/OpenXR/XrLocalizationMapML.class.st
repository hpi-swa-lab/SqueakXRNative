Class {
	#name : #XrLocalizationMapML,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{ #category : #'as yet unclassified' }
XrLocalizationMapML class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(name 'char[64]')
		(mapUuid 'XrUuidEXT')
		(mapType 'XrLocalizationMapTypeML')
	)
]
