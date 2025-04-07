Class {
	#name : #XrLocalizationEnableEventsInfoML,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{ #category : #'as yet unclassified' }
XrLocalizationEnableEventsInfoML class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(enabled 'XrBool32')
	)
]
