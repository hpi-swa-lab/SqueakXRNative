Class {
	#name : #XrSpatialAnchorFromPersistedAnchorCreateInfoMSFT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrSpatialAnchorFromPersistedAnchorCreateInfoMSFT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(spatialAnchorStore 'XrSpatialAnchorStoreConnectionMSFT')
		(spatialAnchorPersistenceName 'XrSpatialAnchorPersistenceNameMSFT')
	)
]
