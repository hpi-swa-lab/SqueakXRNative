Class {
	#name : #XrVisualMeshComputeLodInfoMSFT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{ #category : #'as yet unclassified' }
XrVisualMeshComputeLodInfoMSFT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(lod 'XrMeshComputeLodMSFT')
	)
]
