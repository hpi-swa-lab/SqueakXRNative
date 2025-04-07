Class {
	#name : #XrSystemHandTrackingMeshPropertiesMSFT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{ #category : #'as yet unclassified' }
XrSystemHandTrackingMeshPropertiesMSFT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(supportsHandTrackingMesh 'XrBool32')
		(maxHandMeshIndexCount 'uint32_t')
		(maxHandMeshVertexCount 'uint32_t')
	)
]
