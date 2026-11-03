Class {
	#name : #XrCreateSpatialAnchorsCompletionML,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrCreateSpatialAnchorsCompletionML class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(futureResult 'XrResult')
		(spaceCount 'uint32_t')
		(spaces 'XrSpace*')
	)
]
