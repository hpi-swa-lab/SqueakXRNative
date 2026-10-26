Class {
	#name : #XrCompositionLayerAlphaBlendFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrCompositionLayerAlphaBlendFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(srcFactorColor 'XrBlendFactorFB')
		(dstFactorColor 'XrBlendFactorFB')
		(srcFactorAlpha 'XrBlendFactorFB')
		(dstFactorAlpha 'XrBlendFactorFB')
	)
]
