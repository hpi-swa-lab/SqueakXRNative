Class {
	#name : #XrCompositionLayerBaseHeader,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{ #category : #'as yet unclassified' }
XrCompositionLayerBaseHeader class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(layerFlags 'XrCompositionLayerFlags')
		(space 'XrSpace')
	)
]
