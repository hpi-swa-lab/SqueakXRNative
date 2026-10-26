Class {
	#name : #XrLocalizationEnableEventsInfoML,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrLocalizationEnableEventsInfoML class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(enabled 'XrBool32')
	)
]
