Class {
	#name : #XrLocalizationMapImportInfoML,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{ #category : #'as yet unclassified' }
XrLocalizationMapImportInfoML class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(size 'uint32_t')
		(data 'char*')
	)
]
