Class {
	#name : #XrSpatialAnchorCreateInfoFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{ #category : #'as yet unclassified' }
XrSpatialAnchorCreateInfoFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(space 'XrSpace')
		(poseInSpace 'XrPosef')
		(time 'XrTime')
	)
]
