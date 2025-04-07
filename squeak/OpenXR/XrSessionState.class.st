Class {
	#name : #XrSessionState,
	#superclass : #ExternalTypeAlias,
	#category : #'OpenXR-Typedefs-Generated'
}

{ #category : #'as yet unclassified' }
XrSessionState class >> XR_SESSION_STATE_EXITING [

	^ self on: (8)
]

{ #category : #'as yet unclassified' }
XrSessionState class >> XR_SESSION_STATE_FOCUSED [

	^ self on: (5)
]

{ #category : #'as yet unclassified' }
XrSessionState class >> XR_SESSION_STATE_IDLE [

	^ self on: (1)
]

{ #category : #'as yet unclassified' }
XrSessionState class >> XR_SESSION_STATE_LOSS_PENDING [

	^ self on: (7)
]

{ #category : #'as yet unclassified' }
XrSessionState class >> XR_SESSION_STATE_READY [

	^ self on: (2)
]

{ #category : #'as yet unclassified' }
XrSessionState class >> XR_SESSION_STATE_STOPPING [

	^ self on: (6)
]

{ #category : #'as yet unclassified' }
XrSessionState class >> XR_SESSION_STATE_SYNCHRONIZED [

	^ self on: (3)
]

{ #category : #'as yet unclassified' }
XrSessionState class >> XR_SESSION_STATE_UNKNOWN [

	^ self on: (0)
]

{ #category : #'as yet unclassified' }
XrSessionState class >> XR_SESSION_STATE_VISIBLE [

	^ self on: (4)
]

{ #category : #'as yet unclassified' }
XrSessionState class >> originalTypeName [

    ^ 'long'
]
