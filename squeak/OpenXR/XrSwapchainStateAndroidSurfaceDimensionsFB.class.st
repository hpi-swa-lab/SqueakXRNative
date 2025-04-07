Class {
	#name : #XrSwapchainStateAndroidSurfaceDimensionsFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{ #category : #'as yet unclassified' }
XrSwapchainStateAndroidSurfaceDimensionsFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(width 'uint32_t')
		(height 'uint32_t')
	)
]
