Class {
	#name : #XrSpatialAnchorsPublishCompletionDetailsML,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-6-Generated'
}

{ #category : #'as yet unclassified' }
XrSpatialAnchorsPublishCompletionDetailsML class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(resultCount 'uint32_t')
		(results 'XrSpatialAnchorCompletionResultML*')
	)
]
