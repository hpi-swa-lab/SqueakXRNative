Class {
	#name : #XrHeadsetFitStatusML,
	#superclass : #ExternalTypeAlias,
	#category : #'OpenXR-Typedefs-Generated'
}

{ #category : #'as yet unclassified' }
XrHeadsetFitStatusML class >> XR_HEADSET_FIT_STATUS_BAD_FIT_ML [

	^ self on: (3)
]

{ #category : #'as yet unclassified' }
XrHeadsetFitStatusML class >> XR_HEADSET_FIT_STATUS_GOOD_FIT_ML [

	^ self on: (2)
]

{ #category : #'as yet unclassified' }
XrHeadsetFitStatusML class >> XR_HEADSET_FIT_STATUS_NOT_WORN_ML [

	^ self on: (1)
]

{ #category : #'as yet unclassified' }
XrHeadsetFitStatusML class >> XR_HEADSET_FIT_STATUS_UNKNOWN_ML [

	^ self on: (0)
]

{ #category : #'as yet unclassified' }
XrHeadsetFitStatusML class >> originalTypeName [

    ^ 'long'
]
