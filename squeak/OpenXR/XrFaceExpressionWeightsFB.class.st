Class {
	#name : #XrFaceExpressionWeightsFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrFaceExpressionWeightsFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(weightCount 'uint32_t')
		(weights 'float*')
		(confidenceCount 'uint32_t')
		(confidences 'float*')
		(status 'XrFaceExpressionStatusFB')
		(time 'XrTime')
	)
]
