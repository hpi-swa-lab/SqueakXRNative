Class {
	#name : #XrPassthroughMeshTransformInfoHTC,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrPassthroughMeshTransformInfoHTC class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(vertexCount 'uint32_t')
		(vertices 'XrVector3f*')
		(indexCount 'uint32_t')
		(indices 'uint32_t*')
		(baseSpace 'XrSpace')
		(time 'XrTime')
		(pose 'XrPosef')
		(scale 'XrVector3f')
	)
]
