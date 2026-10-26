Class {
	#name : #XrEventDataPassthroughLayerResumedMETA,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-6-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrEventDataPassthroughLayerResumedMETA class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(layer 'XrPassthroughLayerFB')
	)
]
