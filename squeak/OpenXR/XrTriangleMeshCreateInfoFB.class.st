Class {
	#name : #XrTriangleMeshCreateInfoFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrTriangleMeshCreateInfoFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(flags 'XrTriangleMeshFlagsFB')
		(windingOrder 'XrWindingOrderFB')
		(vertexCount 'uint32_t')
		(vertexBuffer 'XrVector3f*')
		(triangleCount 'uint32_t')
		(indexBuffer 'uint32_t*')
	)
]
