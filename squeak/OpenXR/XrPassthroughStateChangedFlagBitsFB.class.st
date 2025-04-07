Class {
	#name : #XrPassthroughStateChangedFlagBitsFB,
	#superclass : #ExternalTypeAlias,
	#category : #'OpenXR-Typedefs-Generated'
}

{ #category : #'as yet unclassified' }
XrPassthroughStateChangedFlagBitsFB class >> XR_PASSTHROUGH_STATE_CHANGED_NON_RECOVERABLE_ERROR_BIT_FB [

	^ self on: (1 bitShift: 1)
]

{ #category : #'as yet unclassified' }
XrPassthroughStateChangedFlagBitsFB class >> XR_PASSTHROUGH_STATE_CHANGED_RECOVERABLE_ERROR_BIT_FB [

	^ self on: (1 bitShift: 2)
]

{ #category : #'as yet unclassified' }
XrPassthroughStateChangedFlagBitsFB class >> XR_PASSTHROUGH_STATE_CHANGED_REINIT_REQUIRED_BIT_FB [

	^ self on: (1 bitShift: 0)
]

{ #category : #'as yet unclassified' }
XrPassthroughStateChangedFlagBitsFB class >> XR_PASSTHROUGH_STATE_CHANGED_RESTORED_ERROR_BIT_FB [

	^ self on: (1 bitShift: 3)
]

{ #category : #'as yet unclassified' }
XrPassthroughStateChangedFlagBitsFB class >> originalTypeName [

    ^ 'long'
]
