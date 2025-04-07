Class {
	#name : #XrCompositionLayerDepthTestFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrCompositionLayerDepthTestFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(depthMask 'XrBool32')
		(compareOp 'XrCompareOpFB')
	)
]
