Class {
	#name : #XrEventDataLocalizationChangedML,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{ #category : #'as yet unclassified' }
XrEventDataLocalizationChangedML class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(session 'XrSession')
		(state 'XrLocalizationMapStateML')
		(map 'XrLocalizationMapML')
		(confidence 'XrLocalizationMapConfidenceML')
		(errorFlags 'XrLocalizationMapErrorFlagsML')
	)
]
