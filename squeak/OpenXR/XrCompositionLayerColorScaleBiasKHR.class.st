Class {
	#name : #XrCompositionLayerColorScaleBiasKHR,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{ #category : #'as yet unclassified' }
XrCompositionLayerColorScaleBiasKHR class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(colorScale 'XrColor4f')
		(colorBias 'XrColor4f')
	)
]
