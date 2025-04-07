Class {
	#name : #XrActionType,
	#superclass : #ExternalTypeAlias,
	#category : #'OpenXR-Typedefs-Generated'
}

{ #category : #'as yet unclassified' }
XrActionType class >> XR_ACTION_TYPE_BOOLEAN_INPUT [

	^ self on: (1)
]

{ #category : #'as yet unclassified' }
XrActionType class >> XR_ACTION_TYPE_FLOAT_INPUT [

	^ self on: (2)
]

{ #category : #'as yet unclassified' }
XrActionType class >> XR_ACTION_TYPE_POSE_INPUT [

	^ self on: (4)
]

{ #category : #'as yet unclassified' }
XrActionType class >> XR_ACTION_TYPE_VECTOR2F_INPUT [

	^ self on: (3)
]

{ #category : #'as yet unclassified' }
XrActionType class >> XR_ACTION_TYPE_VIBRATION_OUTPUT [

	^ self on: (100)
]

{ #category : #'as yet unclassified' }
XrActionType class >> originalTypeName [

    ^ 'long'
]
