Class {
	#name : #XrViewStateFlagBits,
	#superclass : #ExternalTypeAlias,
	#category : #'OpenXR-Typedefs-Generated'
}

{ #category : #'as yet unclassified' }
XrViewStateFlagBits class >> XR_VIEW_STATE_ORIENTATION_TRACKED_BIT [

	^ self on: (1 bitShift: 2)
]

{ #category : #'as yet unclassified' }
XrViewStateFlagBits class >> XR_VIEW_STATE_ORIENTATION_VALID_BIT [

	^ self on: (1 bitShift: 0)
]

{ #category : #'as yet unclassified' }
XrViewStateFlagBits class >> XR_VIEW_STATE_POSITION_TRACKED_BIT [

	^ self on: (1 bitShift: 3)
]

{ #category : #'as yet unclassified' }
XrViewStateFlagBits class >> XR_VIEW_STATE_POSITION_VALID_BIT [

	^ self on: (1 bitShift: 1)
]

{ #category : #'as yet unclassified' }
XrViewStateFlagBits class >> originalTypeName [

    ^ 'long'
]
