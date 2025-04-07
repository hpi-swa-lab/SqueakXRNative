Class {
	#name : #XrEyeVisibility,
	#superclass : #ExternalTypeAlias,
	#category : #'OpenXR-Typedefs-Generated'
}

{ #category : #'as yet unclassified' }
XrEyeVisibility class >> XR_EYE_VISIBILITY_BOTH [

	^ self on: (0)
]

{ #category : #'as yet unclassified' }
XrEyeVisibility class >> XR_EYE_VISIBILITY_LEFT [

	^ self on: (1)
]

{ #category : #'as yet unclassified' }
XrEyeVisibility class >> XR_EYE_VISIBILITY_RIGHT [

	^ self on: (2)
]

{ #category : #'as yet unclassified' }
XrEyeVisibility class >> originalTypeName [

    ^ 'long'
]
