Class {
	#name : #XrAndroidSurfaceSwapchainFlagBitsFB,
	#superclass : #ExternalTypeAlias,
	#category : #'OpenXR-Typedefs-Generated'
}

{ #category : #'as yet unclassified' }
XrAndroidSurfaceSwapchainFlagBitsFB class >> XR_ANDROID_SURFACE_SWAPCHAIN_SYNCHRONOUS_BIT_FB [

	^ self on: (1 bitShift: 0)
]

{ #category : #'as yet unclassified' }
XrAndroidSurfaceSwapchainFlagBitsFB class >> XR_ANDROID_SURFACE_SWAPCHAIN_USE_TIMESTAMPS_BIT_FB [

	^ self on: (1 bitShift: 1)
]

{ #category : #'as yet unclassified' }
XrAndroidSurfaceSwapchainFlagBitsFB class >> originalTypeName [

    ^ 'long'
]
