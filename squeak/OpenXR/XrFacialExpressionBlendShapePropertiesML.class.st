Class {
	#name : #XrFacialExpressionBlendShapePropertiesML,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
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
