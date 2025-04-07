Class {
	#name : #XrCompositionLayerFlagBits,
	#superclass : #ExternalTypeAlias,
	#category : #'OpenXR-Typedefs-Generated'
}

{ #category : #'as yet unclassified' }
XrCompositionLayerFlagBits class >> XR_COMPOSITION_LAYER_BLEND_TEXTURE_SOURCE_ALPHA_BIT [

	^ self on: (1 bitShift: 1)
]

{ #category : #'as yet unclassified' }
XrCompositionLayerFlagBits class >> XR_COMPOSITION_LAYER_CORRECT_CHROMATIC_ABERRATION_BIT [

	^ self on: (1 bitShift: 0)
]

{ #category : #'as yet unclassified' }
XrCompositionLayerFlagBits class >> XR_COMPOSITION_LAYER_INVERTED_ALPHA_BIT_EXT [

	^ self on: (nil)
]

{ #category : #'as yet unclassified' }
XrCompositionLayerFlagBits class >> XR_COMPOSITION_LAYER_UNPREMULTIPLIED_ALPHA_BIT [

	^ self on: (1 bitShift: 2)
]

{ #category : #'as yet unclassified' }
XrCompositionLayerFlagBits class >> originalTypeName [

    ^ 'long'
]
