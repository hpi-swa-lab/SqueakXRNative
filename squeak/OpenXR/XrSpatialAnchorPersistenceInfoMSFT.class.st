Class {
	#name : #XrSpatialAnchorPersistenceInfoMSFT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrSpatialAnchorPersistenceInfoMSFT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(spatialAnchorPersistenceName 'XrSpatialAnchorPersistenceNameMSFT')
		(spatialAnchor 'XrSpatialAnchorMSFT')
	)
]
