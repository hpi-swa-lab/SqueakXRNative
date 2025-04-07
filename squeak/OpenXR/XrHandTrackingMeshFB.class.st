Class {
	#name : #XrHandTrackingMeshFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{ #category : #'as yet unclassified' }
XrHandTrackingMeshFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(jointCapacityInput 'uint32_t')
		(jointCountOutput 'uint32_t')
		(jointBindPoses 'XrPosef*')
		(jointRadii 'float*')
		(jointParents 'XrHandJointEXT*')
		(vertexCapacityInput 'uint32_t')
		(vertexCountOutput 'uint32_t')
		(vertexPositions 'XrVector3f*')
		(vertexNormals 'XrVector3f*')
		(vertexUVs 'XrVector2f*')
		(vertexBlendIndices 'XrVector4sFB*')
		(vertexBlendWeights 'XrVector4f*')
		(indexCapacityInput 'uint32_t')
		(indexCountOutput 'uint32_t')
		(indices 'int16_t*')
	)
]
