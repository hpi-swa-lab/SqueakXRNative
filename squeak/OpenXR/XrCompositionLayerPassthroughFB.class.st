Class {
	#name : #XrCompositionLayerPassthroughFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrCompositionLayerPassthroughFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(flags 'XrCompositionLayerFlags')
		(space 'XrSpace')
		(layerHandle 'XrPassthroughLayerFB')
	)
]
