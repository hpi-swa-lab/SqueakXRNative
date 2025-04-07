Class {
	#name : #XrEventDataStartColocationDiscoveryCompleteMETA,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrEventDataStartColocationDiscoveryCompleteMETA class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(discoveryRequestId 'XrAsyncRequestIdFB')
		(result 'XrResult')
	)
]
