Class {
	#name : #XrPassthroughCapabilityFlagBitsFB,
	#superclass : #ExternalTypeAlias,
	#category : #'OpenXR-Typedefs-Generated'
}

{ #category : #'as yet unclassified' }
XrPassthroughCapabilityFlagBitsFB class >> XR_PASSTHROUGH_CAPABILITY_BIT_FB [

	^ self on: (1 bitShift: 0)
]

{ #category : #'as yet unclassified' }
XrPassthroughCapabilityFlagBitsFB class >> XR_PASSTHROUGH_CAPABILITY_COLOR_BIT_FB [

	^ self on: (1 bitShift: 1)
]

{ #category : #'as yet unclassified' }
XrPassthroughCapabilityFlagBitsFB class >> XR_PASSTHROUGH_CAPABILITY_LAYER_DEPTH_BIT_FB [

	^ self on: (1 bitShift: 2)
]

{ #category : #'as yet unclassified' }
XrPassthroughCapabilityFlagBitsFB class >> originalTypeName [

    ^ 'long'
]
