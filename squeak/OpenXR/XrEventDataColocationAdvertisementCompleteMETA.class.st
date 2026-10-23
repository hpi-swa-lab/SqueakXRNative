Class {
	#name : #XrEventDataColocationAdvertisementCompleteMETA,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrEventDataColocationAdvertisementCompleteMETA class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(advertisementRequestId 'XrAsyncRequestIdFB')
		(result 'XrResult')
	)
]
