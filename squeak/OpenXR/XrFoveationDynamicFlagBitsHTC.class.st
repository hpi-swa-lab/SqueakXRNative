Class {
	#name : #XrFoveationDynamicFlagBitsHTC,
	#superclass : #ExternalTypeAlias,
	#category : #'OpenXR-Typedefs-Generated'
}

{ #category : #'as yet unclassified' }
XrFoveationDynamicFlagBitsHTC class >> XR_FOVEATION_DYNAMIC_CLEAR_FOV_ENABLED_BIT_HTC [

	^ self on: (1 bitShift: 1)
]

{ #category : #'as yet unclassified' }
XrFoveationDynamicFlagBitsHTC class >> XR_FOVEATION_DYNAMIC_FOCAL_CENTER_OFFSET_ENABLED_BIT_HTC [

	^ self on: (1 bitShift: 2)
]

{ #category : #'as yet unclassified' }
XrFoveationDynamicFlagBitsHTC class >> XR_FOVEATION_DYNAMIC_LEVEL_ENABLED_BIT_HTC [

	^ self on: (1 bitShift: 0)
]

{ #category : #'as yet unclassified' }
XrFoveationDynamicFlagBitsHTC class >> originalTypeName [

    ^ 'long'
]
