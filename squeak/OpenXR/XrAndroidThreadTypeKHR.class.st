Class {
	#name : #XrAndroidThreadTypeKHR,
	#superclass : #ExternalTypeAlias,
	#category : #'OpenXR-Typedefs-Generated'
}

{ #category : #'as yet unclassified' }
XrAndroidThreadTypeKHR class >> XR_ANDROID_THREAD_TYPE_APPLICATION_MAIN_KHR [

	^ self on: (1)
]

{ #category : #'as yet unclassified' }
XrAndroidThreadTypeKHR class >> XR_ANDROID_THREAD_TYPE_APPLICATION_WORKER_KHR [

	^ self on: (2)
]

{ #category : #'as yet unclassified' }
XrAndroidThreadTypeKHR class >> XR_ANDROID_THREAD_TYPE_RENDERER_MAIN_KHR [

	^ self on: (3)
]

{ #category : #'as yet unclassified' }
XrAndroidThreadTypeKHR class >> XR_ANDROID_THREAD_TYPE_RENDERER_WORKER_KHR [

	^ self on: (4)
]

{ #category : #'as yet unclassified' }
XrAndroidThreadTypeKHR class >> originalTypeName [

    ^ 'long'
]
