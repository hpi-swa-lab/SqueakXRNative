Class {
	#name : #XrMarkerDetectorStateML,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{ #category : #'as yet unclassified' }
XrMarkerDetectorStateML class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(state 'XrMarkerDetectorStatusML')
	)
]
