Class {
	#name : #XrExternalCameraExtrinsicsOCULUS,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrExternalCameraExtrinsicsOCULUS class >> fields [

	^ #(
		(lastChangeTime 'XrTime')
		(cameraStatusFlags 'XrExternalCameraStatusFlagsOCULUS')
		(attachedToDevice 'XrExternalCameraAttachedToDeviceOCULUS')
		(relativePose 'XrPosef')
	)
]
