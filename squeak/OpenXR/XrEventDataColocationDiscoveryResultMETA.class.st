Class {
	#name : #XrEventDataColocationDiscoveryResultMETA,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
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
