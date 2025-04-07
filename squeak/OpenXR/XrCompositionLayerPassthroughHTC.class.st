Class {
	#name : #XrCompositionLayerPassthroughHTC,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrCompositionLayerPassthroughHTC class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(layerFlags 'XrCompositionLayerFlags')
		(space 'XrSpace')
		(passthrough 'XrPassthroughHTC')
		(color 'XrPassthroughColorHTC')
	)
]
