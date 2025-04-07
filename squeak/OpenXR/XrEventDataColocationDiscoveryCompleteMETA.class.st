Class {
	#name : #XrEventDataColocationDiscoveryCompleteMETA,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrEventDataColocationDiscoveryCompleteMETA class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(discoveryRequestId 'XrAsyncRequestIdFB')
		(result 'XrResult')
	)
]
