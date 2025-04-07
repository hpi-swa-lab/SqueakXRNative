Class {
	#name : #XrSpatialAnchorCreateInfoHTC,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrSpatialAnchorCreateInfoHTC class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(space 'XrSpace')
		(poseInSpace 'XrPosef')
		(name 'XrSpatialAnchorNameHTC')
	)
]
