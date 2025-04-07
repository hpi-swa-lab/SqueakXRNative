Class {
	#name : #XrEventDataStartColocationAdvertisementCompleteMETA,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrEventDataStartColocationAdvertisementCompleteMETA class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(advertisementRequestId 'XrAsyncRequestIdFB')
		(result 'XrResult')
		(advertisementUuid 'XrUuid')
	)
]
