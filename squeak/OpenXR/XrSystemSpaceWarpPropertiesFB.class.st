Class {
	#name : #XrSystemSpaceWarpPropertiesFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrSystemSpaceWarpPropertiesFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(recommendedMotionVectorImageRectWidth 'uint32_t')
		(recommendedMotionVectorImageRectHeight 'uint32_t')
	)
]
