Class {
	#name : #XrKeyboardTrackingQueryFlagBitsFB,
	#superclass : #ExternalTypeAlias,
	#category : #'OpenXR-Typedefs-Generated'
}

{ #category : #'as yet unclassified' }
XrKeyboardTrackingQueryFlagBitsFB class >> XR_KEYBOARD_TRACKING_QUERY_LOCAL_BIT_FB [

	^ self on: (1 bitShift: 1)
]

{ #category : #'as yet unclassified' }
XrKeyboardTrackingQueryFlagBitsFB class >> XR_KEYBOARD_TRACKING_QUERY_REMOTE_BIT_FB [

	^ self on: (1 bitShift: 2)
]

{ #category : #'as yet unclassified' }
XrKeyboardTrackingQueryFlagBitsFB class >> originalTypeName [

    ^ 'long'
]
