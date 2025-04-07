Class {
	#name : #XrFrameEndInfoFlagBitsML,
	#superclass : #ExternalTypeAlias,
	#category : #'OpenXR-Typedefs-Generated'
}

{ #category : #'as yet unclassified' }
XrFrameEndInfoFlagBitsML class >> XR_FRAME_END_INFO_PROTECTED_BIT_ML [

	^ self on: (1 bitShift: 0)
]

{ #category : #'as yet unclassified' }
XrFrameEndInfoFlagBitsML class >> XR_FRAME_END_INFO_VIGNETTE_BIT_ML [

	^ self on: (1 bitShift: 1)
]

{ #category : #'as yet unclassified' }
XrFrameEndInfoFlagBitsML class >> originalTypeName [

    ^ 'long'
]
