Class {
	#name : #XrSystemFacialExpressionPropertiesML,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{ #category : #'as yet unclassified' }
XrSystemFacialExpressionPropertiesML class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(supportsFacialExpression 'XrBool32')
	)
]
