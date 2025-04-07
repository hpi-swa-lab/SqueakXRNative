Class {
	#name : #XrFormFactor,
	#superclass : #ExternalTypeAlias,
	#category : #'OpenXR-Typedefs-Generated'
}

{ #category : #'as yet unclassified' }
XrFormFactor class >> XR_FORM_FACTOR_HANDHELD_DISPLAY [

	^ self on: (2)
]

{ #category : #'as yet unclassified' }
XrFormFactor class >> XR_FORM_FACTOR_HEAD_MOUNTED_DISPLAY [

	^ self on: (1)
]

{ #category : #'as yet unclassified' }
XrFormFactor class >> originalTypeName [

    ^ 'long'
]
