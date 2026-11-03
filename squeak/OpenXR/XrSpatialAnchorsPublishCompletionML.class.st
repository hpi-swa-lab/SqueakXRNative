Class {
	#name : #XrSpatialAnchorsPublishCompletionML,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-6-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrSpatialAnchorsPublishCompletionML class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(futureResult 'XrResult')
		(uuidCount 'uint32_t')
		(uuids 'XrUuidEXT*')
	)
]
