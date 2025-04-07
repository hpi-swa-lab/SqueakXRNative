Class {
	#name : #XrFaceExpressionWeights2FB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{ #category : #'as yet unclassified' }
XrFaceExpressionWeights2FB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(weightCount 'uint32_t')
		(weights 'float*')
		(confidenceCount 'uint32_t')
		(confidences 'float*')
		(isValid 'XrBool32')
		(isEyeFollowingBlendshapesValid 'XrBool32')
		(dataSource 'XrFaceTrackingDataSource2FB')
		(time 'XrTime')
	)
]
