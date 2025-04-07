Class {
	#name : #XrSwapchainUsageFlagBits,
	#superclass : #ExternalTypeAlias,
	#category : #'OpenXR-Typedefs-Generated'
}

{ #category : #'as yet unclassified' }
XrSwapchainUsageFlagBits class >> XR_SWAPCHAIN_USAGE_COLOR_ATTACHMENT_BIT [

	^ self on: (1 bitShift: 0)
]

{ #category : #'as yet unclassified' }
XrSwapchainUsageFlagBits class >> XR_SWAPCHAIN_USAGE_DEPTH_STENCIL_ATTACHMENT_BIT [

	^ self on: (1 bitShift: 1)
]

{ #category : #'as yet unclassified' }
XrSwapchainUsageFlagBits class >> XR_SWAPCHAIN_USAGE_INPUT_ATTACHMENT_BIT_KHR [

	^ self on: (nil)
]

{ #category : #'as yet unclassified' }
XrSwapchainUsageFlagBits class >> XR_SWAPCHAIN_USAGE_INPUT_ATTACHMENT_BIT_MND [

	^ self on: (nil)
]

{ #category : #'as yet unclassified' }
XrSwapchainUsageFlagBits class >> XR_SWAPCHAIN_USAGE_MUTABLE_FORMAT_BIT [

	^ self on: (1 bitShift: 6)
]

{ #category : #'as yet unclassified' }
XrSwapchainUsageFlagBits class >> XR_SWAPCHAIN_USAGE_SAMPLED_BIT [

	^ self on: (1 bitShift: 5)
]

{ #category : #'as yet unclassified' }
XrSwapchainUsageFlagBits class >> XR_SWAPCHAIN_USAGE_TRANSFER_DST_BIT [

	^ self on: (1 bitShift: 4)
]

{ #category : #'as yet unclassified' }
XrSwapchainUsageFlagBits class >> XR_SWAPCHAIN_USAGE_TRANSFER_SRC_BIT [

	^ self on: (1 bitShift: 3)
]

{ #category : #'as yet unclassified' }
XrSwapchainUsageFlagBits class >> XR_SWAPCHAIN_USAGE_UNORDERED_ACCESS_BIT [

	^ self on: (1 bitShift: 2)
]

{ #category : #'as yet unclassified' }
XrSwapchainUsageFlagBits class >> originalTypeName [

    ^ 'long'
]
