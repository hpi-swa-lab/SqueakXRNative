Class {
	#name : #XrMarkerDetectorAprilTagInfoML,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{ #category : #'as yet unclassified' }
XrMarkerDetectorAprilTagInfoML class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(aprilTagDict 'XrMarkerAprilTagDictML')
	)
]
