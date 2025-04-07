Class {
	#name : #XrFrameEndInfo,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{ #category : #'as yet unclassified' }
XrFrameEndInfo class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(displayTime 'XrTime')
		(environmentBlendMode 'XrEnvironmentBlendMode')
		(layerCount 'uint32_t')
		(layers 'XrCompositionLayerBaseHeader*')
	)
]
