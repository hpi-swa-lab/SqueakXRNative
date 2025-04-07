Class {
	#name : #XrDebugUtilsMessageTypeFlagBitsEXT,
	#superclass : #ExternalTypeAlias,
	#category : #'OpenXR-Typedefs-Generated'
}

{ #category : #'as yet unclassified' }
XrDebugUtilsMessageTypeFlagBitsEXT class >> XR_DEBUG_UTILS_MESSAGE_TYPE_CONFORMANCE_BIT_EXT [

	^ self on: (1 bitShift: 3)
]

{ #category : #'as yet unclassified' }
XrDebugUtilsMessageTypeFlagBitsEXT class >> XR_DEBUG_UTILS_MESSAGE_TYPE_GENERAL_BIT_EXT [

	^ self on: (1 bitShift: 0)
]

{ #category : #'as yet unclassified' }
XrDebugUtilsMessageTypeFlagBitsEXT class >> XR_DEBUG_UTILS_MESSAGE_TYPE_PERFORMANCE_BIT_EXT [

	^ self on: (1 bitShift: 2)
]

{ #category : #'as yet unclassified' }
XrDebugUtilsMessageTypeFlagBitsEXT class >> XR_DEBUG_UTILS_MESSAGE_TYPE_VALIDATION_BIT_EXT [

	^ self on: (1 bitShift: 1)
]

{ #category : #'as yet unclassified' }
XrDebugUtilsMessageTypeFlagBitsEXT class >> originalTypeName [

    ^ 'long'
]
