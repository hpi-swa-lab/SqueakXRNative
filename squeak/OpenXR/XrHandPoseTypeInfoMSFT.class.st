Class {
	#name : #XrHandPoseTypeInfoMSFT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{ #category : #'as yet unclassified' }
XrHandPoseTypeInfoMSFT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(handPoseType 'XrHandPoseTypeMSFT')
	)
]
