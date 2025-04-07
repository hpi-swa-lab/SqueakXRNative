Class {
	#name : #XrFrameSynthesisInfoFlagBitsEXT,
	#superclass : #ExternalTypeAlias,
	#category : #'OpenXR-Typedefs-Generated'
}

{ #category : #'as yet unclassified' }
XrFrameSynthesisInfoFlagBitsEXT class >> XR_FRAME_SYNTHESIS_INFO_REQUEST_RELAXED_FRAME_INTERVAL_BIT_EXT [

	^ self on: (1 bitShift: 1)
]

{ #category : #'as yet unclassified' }
XrFrameSynthesisInfoFlagBitsEXT class >> XR_FRAME_SYNTHESIS_INFO_USE_2D_MOTION_VECTOR_BIT_EXT [

	^ self on: (1 bitShift: 0)
]

{ #category : #'as yet unclassified' }
XrFrameSynthesisInfoFlagBitsEXT class >> originalTypeName [

    ^ 'long'
]
