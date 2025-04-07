Class {
	#name : #XrMapLocalizationRequestInfoML,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{ #category : #'as yet unclassified' }
XrMapLocalizationRequestInfoML class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(mapUuid 'XrUuidEXT')
	)
]
