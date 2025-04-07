Class {
	#name : #XrSwapchainCreateFlagBits,
	#superclass : #ExternalTypeAlias,
	#category : #'OpenXR-Typedefs-Generated'
}

{ #category : #'as yet unclassified' }
XrSwapchainCreateFlagBits class >> XR_SWAPCHAIN_CREATE_PROTECTED_CONTENT_BIT [

	^ self on: (1 bitShift: 0)
]

{ #category : #'as yet unclassified' }
XrSwapchainCreateFlagBits class >> XR_SWAPCHAIN_CREATE_STATIC_IMAGE_BIT [

	^ self on: (1 bitShift: 1)
]

{ #category : #'as yet unclassified' }
XrSwapchainCreateFlagBits class >> originalTypeName [

    ^ 'long'
]
