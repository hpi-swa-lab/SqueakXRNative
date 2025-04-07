Class {
	#name : #XrEventDataColocationDiscoveryResultMETA,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrEventDataColocationDiscoveryResultMETA class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(discoveryRequestId 'XrAsyncRequestIdFB')
		(advertisementUuid 'XrUuid')
		(bufferSize 'uint32_t')
		(buffer 'uint8_t[1024]')
	)
]
