Class {
	#name : #XrVisibilityMaskKHR,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrVisibilityMaskKHR class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(vertexCapacityInput 'uint32_t')
		(vertexCountOutput 'uint32_t')
		(vertices 'XrVector2f*')
		(indexCapacityInput 'uint32_t')
		(indexCountOutput 'uint32_t')
		(indices 'uint32_t*')
	)
]
