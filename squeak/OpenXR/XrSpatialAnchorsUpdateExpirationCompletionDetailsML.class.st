Class {
	#name : #XrSpatialAnchorsUpdateExpirationCompletionDetailsML,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-6-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrSpatialAnchorsUpdateExpirationCompletionDetailsML class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(resultCount 'uint32_t')
		(results 'XrSpatialAnchorCompletionResultML*')
	)
]
