Class {
	#name : #XrFrameSynthesisConfigViewEXT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{ #category : #'as yet unclassified' }
XrFrameSynthesisConfigViewEXT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(recommendedMotionVectorImageRectWidth 'uint32_t')
		(recommendedMotionVectorImageRectHeight 'uint32_t')
	)
]
