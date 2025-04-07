Class {
	#name : #XrEventDataColocationAdvertisementCompleteMETA,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrEventDataColocationAdvertisementCompleteMETA class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(advertisementRequestId 'XrAsyncRequestIdFB')
		(result 'XrResult')
	)
]
