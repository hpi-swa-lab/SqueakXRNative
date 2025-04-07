Class {
	#name : #XrRecommendedLayerResolutionGetInfoMETA,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{ #category : #'as yet unclassified' }
XrRecommendedLayerResolutionGetInfoMETA class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(layer 'XrCompositionLayerBaseHeader*')
		(predictedDisplayTime 'XrTime')
	)
]
