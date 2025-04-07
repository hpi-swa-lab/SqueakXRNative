Class {
	#name : #XrSystemMarkerUnderstandingPropertiesML,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{ #category : #'as yet unclassified' }
XrSystemMarkerUnderstandingPropertiesML class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(supportsMarkerUnderstanding 'XrBool32')
	)
]
