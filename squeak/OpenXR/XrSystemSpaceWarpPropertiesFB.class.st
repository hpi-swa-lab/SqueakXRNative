Class {
	#name : #XrSystemSpaceWarpPropertiesFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrSystemSpaceWarpPropertiesFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(recommendedMotionVectorImageRectWidth 'uint32_t')
		(recommendedMotionVectorImageRectHeight 'uint32_t')
	)
]
