Class {
	#name : #XrDebugUtilsMessageSeverityFlagBitsEXT,
	#superclass : #ExternalTypeAlias,
	#category : #'OpenXR-Typedefs-Generated'
}

{ #category : #'as yet unclassified' }
XrDebugUtilsMessageSeverityFlagBitsEXT class >> XR_DEBUG_UTILS_MESSAGE_SEVERITY_ERROR_BIT_EXT [

	^ self on: (1 bitShift: 12)
]

{ #category : #'as yet unclassified' }
XrDebugUtilsMessageSeverityFlagBitsEXT class >> XR_DEBUG_UTILS_MESSAGE_SEVERITY_INFO_BIT_EXT [

	^ self on: (1 bitShift: 4)
]

{ #category : #'as yet unclassified' }
XrDebugUtilsMessageSeverityFlagBitsEXT class >> XR_DEBUG_UTILS_MESSAGE_SEVERITY_VERBOSE_BIT_EXT [

	^ self on: (1 bitShift: 0)
]

{ #category : #'as yet unclassified' }
XrDebugUtilsMessageSeverityFlagBitsEXT class >> XR_DEBUG_UTILS_MESSAGE_SEVERITY_WARNING_BIT_EXT [

	^ self on: (1 bitShift: 8)
]

{ #category : #'as yet unclassified' }
XrDebugUtilsMessageSeverityFlagBitsEXT class >> originalTypeName [

    ^ 'long'
]
