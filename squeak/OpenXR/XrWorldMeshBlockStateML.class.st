Class {
	#name : #XrWorldMeshBlockStateML,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-6-Generated'
}

{ #category : #'as yet unclassified' }
XrWorldMeshBlockStateML class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(uuid 'XrUuidEXT')
		(meshBoundingBoxCenter 'XrPosef')
		(meshBoundingBoxExtents 'XrExtent3DfEXT')
		(lastUpdateTime 'XrTime')
		(status 'XrWorldMeshBlockStatusML')
	)
]
