Class {
	#name : #XrFacialExpressionsHTC,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
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
