Class {
	#name : #XrKeyboardTrackingFlagBitsFB,
	#superclass : #ExternalTypeAlias,
	#category : #'OpenXR-Typedefs-Generated'
}

{ #category : #'as yet unclassified' }
XrKeyboardTrackingFlagBitsFB class >> XR_KEYBOARD_TRACKING_CONNECTED_BIT_FB [

	^ self on: (1 bitShift: 3)
]

{ #category : #'as yet unclassified' }
XrKeyboardTrackingFlagBitsFB class >> XR_KEYBOARD_TRACKING_EXISTS_BIT_FB [

	^ self on: (1 bitShift: 0)
]

{ #category : #'as yet unclassified' }
XrKeyboardTrackingFlagBitsFB class >> XR_KEYBOARD_TRACKING_LOCAL_BIT_FB [

	^ self on: (1 bitShift: 1)
]

{ #category : #'as yet unclassified' }
XrKeyboardTrackingFlagBitsFB class >> XR_KEYBOARD_TRACKING_REMOTE_BIT_FB [

	^ self on: (1 bitShift: 2)
]

{ #category : #'as yet unclassified' }
XrKeyboardTrackingFlagBitsFB class >> originalTypeName [

    ^ 'long'
]
