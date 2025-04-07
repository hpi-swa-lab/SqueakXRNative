Class {
	#name : #XrSpatialAnchorsDeleteCompletionDetailsML,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-6-Generated'
}

{ #category : #'as yet unclassified' }
XrSpatialAnchorsDeleteCompletionDetailsML class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(resultCount 'uint32_t')
		(results 'XrSpatialAnchorCompletionResultML*')
	)
]
