Class {
	#name : #XrCompositionLayerReprojectionInfoMSFT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrCompositionLayerReprojectionInfoMSFT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(reprojectionMode 'XrReprojectionModeMSFT')
	)
]
