Class {
	#name : #XrCompositionLayerColorScaleBiasKHR,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrCompositionLayerColorScaleBiasKHR class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(colorScale 'XrColor4f')
		(colorBias 'XrColor4f')
	)
]
