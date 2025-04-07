Class {
	#name : #XrEventDataSpaceQueryResultsAvailableFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{ #category : #'as yet unclassified' }
XrEventDataSpaceQueryResultsAvailableFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(requestId 'XrAsyncRequestIdFB')
	)
]
