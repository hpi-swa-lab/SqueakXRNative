Class {
	#name : #XrMarkerDetectorSizeInfoML,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{ #category : #'as yet unclassified' }
XrMarkerDetectorSizeInfoML class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(markerLength 'float')
	)
]
