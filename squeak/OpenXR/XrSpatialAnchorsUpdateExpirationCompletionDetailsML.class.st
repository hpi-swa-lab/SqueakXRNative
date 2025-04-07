Class {
	#name : #XrSpatialAnchorsUpdateExpirationCompletionDetailsML,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-6-Generated'
}

{ #category : #'as yet unclassified' }
XrSpatialAnchorsUpdateExpirationCompletionDetailsML class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(resultCount 'uint32_t')
		(results 'XrSpatialAnchorCompletionResultML*')
	)
]
