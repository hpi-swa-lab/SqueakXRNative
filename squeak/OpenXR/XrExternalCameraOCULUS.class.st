Class {
	#name : #XrExternalCameraOCULUS,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrExternalCameraOCULUS class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(name 'char[32]')
		(intrinsics 'XrExternalCameraIntrinsicsOCULUS')
		(extrinsics 'XrExternalCameraExtrinsicsOCULUS')
	)
]
