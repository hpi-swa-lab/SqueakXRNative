Class {
	#name : #XrLocalizationMapML,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrLocalizationMapML class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(name 'char[64]')
		(mapUuid 'XrUuidEXT')
		(mapType 'XrLocalizationMapTypeML')
	)
]
