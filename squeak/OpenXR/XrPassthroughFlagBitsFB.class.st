Class {
	#name : #XrPassthroughFlagBitsFB,
	#superclass : #ExternalTypeAlias,
	#category : #'OpenXR-Typedefs-Generated'
}

{ #category : #'as yet unclassified' }
XrPassthroughFlagBitsFB class >> XR_PASSTHROUGH_IS_RUNNING_AT_CREATION_BIT_FB [

	^ self on: (1 bitShift: 0)
]

{ #category : #'as yet unclassified' }
XrPassthroughFlagBitsFB class >> XR_PASSTHROUGH_LAYER_DEPTH_BIT_FB [

	^ self on: (1 bitShift: 1)
]

{ #category : #'as yet unclassified' }
XrPassthroughFlagBitsFB class >> originalTypeName [

    ^ 'long'
]
