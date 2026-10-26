Class {
	#name : #XrSpatialAnchorsQueryCompletionML,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrSpatialAnchorsQueryCompletionML class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(futureResult 'XrResult')
		(uuidCapacityInput 'uint32_t')
		(uuidCountOutput 'uint32_t')
		(uuids 'XrUuidEXT*')
	)
]
