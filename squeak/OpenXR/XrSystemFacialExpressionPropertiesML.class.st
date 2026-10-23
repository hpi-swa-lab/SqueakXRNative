Class {
	#name : #XrSystemFacialExpressionPropertiesML,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrSystemFacialExpressionPropertiesML class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(supportsFacialExpression 'XrBool32')
	)
]
