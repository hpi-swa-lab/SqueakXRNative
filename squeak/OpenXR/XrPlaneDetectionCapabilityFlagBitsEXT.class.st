Class {
	#name : #XrPlaneDetectionCapabilityFlagBitsEXT,
	#superclass : #ExternalTypeAlias,
	#category : #'OpenXR-Typedefs-Generated'
}

{ #category : #'as yet unclassified' }
XrPlaneDetectionCapabilityFlagBitsEXT class >> XR_PLANE_DETECTION_CAPABILITY_ORIENTATION_BIT_EXT [

	^ self on: (1 bitShift: 6)
]

{ #category : #'as yet unclassified' }
XrPlaneDetectionCapabilityFlagBitsEXT class >> XR_PLANE_DETECTION_CAPABILITY_PLANE_DETECTION_BIT_EXT [

	^ self on: (1 bitShift: 0)
]

{ #category : #'as yet unclassified' }
XrPlaneDetectionCapabilityFlagBitsEXT class >> XR_PLANE_DETECTION_CAPABILITY_PLANE_HOLES_BIT_EXT [

	^ self on: (1 bitShift: 1)
]

{ #category : #'as yet unclassified' }
XrPlaneDetectionCapabilityFlagBitsEXT class >> XR_PLANE_DETECTION_CAPABILITY_SEMANTIC_CEILING_BIT_EXT [

	^ self on: (1 bitShift: 2)
]

{ #category : #'as yet unclassified' }
XrPlaneDetectionCapabilityFlagBitsEXT class >> XR_PLANE_DETECTION_CAPABILITY_SEMANTIC_FLOOR_BIT_EXT [

	^ self on: (1 bitShift: 3)
]

{ #category : #'as yet unclassified' }
XrPlaneDetectionCapabilityFlagBitsEXT class >> XR_PLANE_DETECTION_CAPABILITY_SEMANTIC_PLATFORM_BIT_EXT [

	^ self on: (1 bitShift: 5)
]

{ #category : #'as yet unclassified' }
XrPlaneDetectionCapabilityFlagBitsEXT class >> XR_PLANE_DETECTION_CAPABILITY_SEMANTIC_WALL_BIT_EXT [

	^ self on: (1 bitShift: 4)
]

{ #category : #'as yet unclassified' }
XrPlaneDetectionCapabilityFlagBitsEXT class >> originalTypeName [

    ^ 'long'
]
