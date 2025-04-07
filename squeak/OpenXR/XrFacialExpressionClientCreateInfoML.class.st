Class {
	#name : #XrFacialExpressionClientCreateInfoML,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{ #category : #'as yet unclassified' }
XrFacialExpressionClientCreateInfoML class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(requestedCount 'uint32_t')
		(requestedFacialBlendShapes 'XrFacialBlendShapeML*')
	)
]
