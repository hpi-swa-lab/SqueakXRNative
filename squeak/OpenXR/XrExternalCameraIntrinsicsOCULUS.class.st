Class {
	#name : #XrExternalCameraIntrinsicsOCULUS,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrExternalCameraIntrinsicsOCULUS class >> fields [

	^ #(
		(lastChangeTime 'XrTime')
		(fov 'XrFovf')
		(virtualNearPlaneDistance 'float')
		(virtualFarPlaneDistance 'float')
		(imageSensorPixelResolution 'XrExtent2Di')
	)
]
