Class {
	#name : #XrCompositionLayerProjection,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{ #category : #'as yet unclassified' }
XrCompositionLayerProjection class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(layerFlags 'XrCompositionLayerFlags')
		(space 'XrSpace')
		(viewCount 'uint32_t')
		(views 'XrCompositionLayerProjectionView*')
	)
]
