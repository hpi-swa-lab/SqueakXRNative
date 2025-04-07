Class {
	#name : #XrHandMeshUpdateInfoMSFT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{ #category : #'as yet unclassified' }
XrHandMeshUpdateInfoMSFT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(time 'XrTime')
		(handPoseType 'XrHandPoseTypeMSFT')
	)
]
