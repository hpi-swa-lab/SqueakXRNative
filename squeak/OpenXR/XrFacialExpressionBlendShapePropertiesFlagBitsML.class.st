Class {
	#name : #XrFacialExpressionBlendShapePropertiesFlagBitsML,
	#superclass : #ExternalTypeAlias,
	#category : #'OpenXR-Typedefs-Generated'
}

{ #category : #'as yet unclassified' }
XrFacialExpressionBlendShapePropertiesFlagBitsML class >> XR_FACIAL_EXPRESSION_BLEND_SHAPE_PROPERTIES_TRACKED_BIT_ML [

	^ self on: (1 bitShift: 1)
]

{ #category : #'as yet unclassified' }
XrFacialExpressionBlendShapePropertiesFlagBitsML class >> XR_FACIAL_EXPRESSION_BLEND_SHAPE_PROPERTIES_VALID_BIT_ML [

	^ self on: (1 bitShift: 0)
]

{ #category : #'as yet unclassified' }
XrFacialExpressionBlendShapePropertiesFlagBitsML class >> originalTypeName [

    ^ 'long'
]
