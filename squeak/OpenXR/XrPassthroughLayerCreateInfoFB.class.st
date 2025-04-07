Class {
	#name : #XrPassthroughLayerCreateInfoFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrPassthroughLayerCreateInfoFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(passthrough 'XrPassthroughFB')
		(flags 'XrPassthroughFlagsFB')
		(purpose 'XrPassthroughLayerPurposeFB')
	)
]
