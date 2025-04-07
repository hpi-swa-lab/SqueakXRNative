Class {
	#name : #XrFacialExpressionsHTC,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrFacialExpressionsHTC class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(isActive 'XrBool32')
		(sampleTime 'XrTime')
		(expressionCount 'uint32_t')
		(expressionWeightings 'float*')
	)
]
