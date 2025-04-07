Class {
	#name : #XrSecondaryViewConfigurationLayerInfoMSFT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{ #category : #'as yet unclassified' }
XrSecondaryViewConfigurationLayerInfoMSFT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(viewConfigurationType 'XrViewConfigurationType')
		(environmentBlendMode 'XrEnvironmentBlendMode')
		(layerCount 'uint32_t')
		(layers 'XrCompositionLayerBaseHeader*')
	)
]
