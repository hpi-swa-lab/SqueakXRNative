Class {
	#name : #XrCompositionLayerSecureContentFlagBitsFB,
	#superclass : #ExternalTypeAlias,
	#category : #'OpenXR-Typedefs-Generated'
}

{ #category : #'as yet unclassified' }
XrCompositionLayerSecureContentFlagBitsFB class >> XR_COMPOSITION_LAYER_SECURE_CONTENT_EXCLUDE_LAYER_BIT_FB [

	^ self on: (1 bitShift: 0)
]

{ #category : #'as yet unclassified' }
XrCompositionLayerSecureContentFlagBitsFB class >> XR_COMPOSITION_LAYER_SECURE_CONTENT_REPLACE_LAYER_BIT_FB [

	^ self on: (1 bitShift: 1)
]

{ #category : #'as yet unclassified' }
XrCompositionLayerSecureContentFlagBitsFB class >> originalTypeName [

    ^ 'long'
]
