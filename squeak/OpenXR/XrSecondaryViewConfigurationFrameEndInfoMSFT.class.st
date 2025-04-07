Class {
	#name : #XrSecondaryViewConfigurationFrameEndInfoMSFT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{ #category : #'as yet unclassified' }
XrSecondaryViewConfigurationFrameEndInfoMSFT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(viewConfigurationCount 'uint32_t')
		(viewConfigurationLayersInfo 'XrSecondaryViewConfigurationLayerInfoMSFT*')
	)
]
