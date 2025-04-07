Class {
	#name : #XrEventDataStopColocationAdvertisementCompleteMETA,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrEventDataStopColocationAdvertisementCompleteMETA class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(requestId 'XrAsyncRequestIdFB')
		(result 'XrResult')
	)
]
