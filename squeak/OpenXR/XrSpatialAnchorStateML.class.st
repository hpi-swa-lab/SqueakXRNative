Class {
	#name : #XrSpatialAnchorStateML,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{ #category : #'as yet unclassified' }
XrSpatialAnchorStateML class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(confidence 'XrSpatialAnchorConfidenceML')
	)
]
