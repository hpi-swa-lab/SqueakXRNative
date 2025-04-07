Class {
	#name : #XrExternalCameraStatusFlagBitsOCULUS,
	#superclass : #ExternalTypeAlias,
	#category : #'OpenXR-Typedefs-Generated'
}

{ #category : #'as yet unclassified' }
XrExternalCameraStatusFlagBitsOCULUS class >> XR_EXTERNAL_CAMERA_STATUS_CALIBRATED_BIT_OCULUS [

	^ self on: (1 bitShift: 3)
]

{ #category : #'as yet unclassified' }
XrExternalCameraStatusFlagBitsOCULUS class >> XR_EXTERNAL_CAMERA_STATUS_CALIBRATING_BIT_OCULUS [

	^ self on: (1 bitShift: 1)
]

{ #category : #'as yet unclassified' }
XrExternalCameraStatusFlagBitsOCULUS class >> XR_EXTERNAL_CAMERA_STATUS_CALIBRATION_FAILED_BIT_OCULUS [

	^ self on: (1 bitShift: 2)
]

{ #category : #'as yet unclassified' }
XrExternalCameraStatusFlagBitsOCULUS class >> XR_EXTERNAL_CAMERA_STATUS_CAPTURING_BIT_OCULUS [

	^ self on: (1 bitShift: 4)
]

{ #category : #'as yet unclassified' }
XrExternalCameraStatusFlagBitsOCULUS class >> XR_EXTERNAL_CAMERA_STATUS_CONNECTED_BIT_OCULUS [

	^ self on: (1 bitShift: 0)
]

{ #category : #'as yet unclassified' }
XrExternalCameraStatusFlagBitsOCULUS class >> originalTypeName [

    ^ 'long'
]
