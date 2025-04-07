Class {
	#name : #XrCompositionLayerAlphaBlendFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{ #category : #'as yet unclassified' }
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
