Class {
	#name : #XrSpatialAnchorSpaceCreateInfoMSFT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{ #category : #'as yet unclassified' }
XrSpatialAnchorSpaceCreateInfoMSFT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(anchor 'XrSpatialAnchorMSFT')
		(poseInAnchorSpace 'XrPosef')
	)
]
