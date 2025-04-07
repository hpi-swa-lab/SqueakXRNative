Class {
	#name : #XrRecommendedLayerResolutionMETA,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{ #category : #'as yet unclassified' }
XrRecommendedLayerResolutionMETA class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(recommendedImageDimensions 'XrExtent2Di')
		(isValid 'XrBool32')
	)
]
