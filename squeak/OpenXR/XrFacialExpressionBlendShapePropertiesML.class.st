Class {
	#name : #XrFacialExpressionBlendShapePropertiesML,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{ #category : #'as yet unclassified' }
XrFacialExpressionBlendShapePropertiesML class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(requestedFacialBlendShape 'XrFacialBlendShapeML')
		(weight 'float')
		(flags 'XrFacialExpressionBlendShapePropertiesFlagsML')
		(time 'XrTime')
	)
]
