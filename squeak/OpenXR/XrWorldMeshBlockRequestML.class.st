Class {
	#name : #XrWorldMeshBlockRequestML,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-6-Generated'
}

{ #category : #'as yet unclassified' }
XrWorldMeshBlockRequestML class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(uuid 'XrUuidEXT')
		(lod 'XrWorldMeshDetectorLodML')
	)
]
