Class {
	#name : #XrWorldMeshBlockML,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-6-Generated'
}

{ #category : #'as yet unclassified' }
XrWorldMeshBlockML class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(uuid 'XrUuidEXT')
		(blockResult 'XrWorldMeshBlockResultML')
		(lod 'XrWorldMeshDetectorLodML')
		(flags 'XrWorldMeshDetectorFlagsML')
		(indexCount 'uint32_t')
		(indexBuffer 'uint16_t*')
		(vertexCount 'uint32_t')
		(vertexBuffer 'XrVector3f*')
		(normalCount 'uint32_t')
		(normalBuffer 'XrVector3f*')
		(confidenceCount 'uint32_t')
		(confidenceBuffer 'float*')
	)
]
