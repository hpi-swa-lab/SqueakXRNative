Class {
	#name : #XrMarkerDetectorArucoInfoML,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{ #category : #'as yet unclassified' }
XrMarkerDetectorArucoInfoML class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(arucoDict 'XrMarkerArucoDictML')
	)
]
