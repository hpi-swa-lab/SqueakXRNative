Class {
	#name : #XrSystemHandTrackingMeshPropertiesMSFT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrSystemHandTrackingMeshPropertiesMSFT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(supportsHandTrackingMesh 'XrBool32')
		(maxHandMeshIndexCount 'uint32_t')
		(maxHandMeshVertexCount 'uint32_t')
	)
]
