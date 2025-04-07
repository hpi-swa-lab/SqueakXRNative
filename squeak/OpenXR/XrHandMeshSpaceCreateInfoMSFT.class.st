Class {
	#name : #XrHandMeshSpaceCreateInfoMSFT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{ #category : #'as yet unclassified' }
XrHandMeshSpaceCreateInfoMSFT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(handPoseType 'XrHandPoseTypeMSFT')
		(poseInHandMeshSpace 'XrPosef')
	)
]
