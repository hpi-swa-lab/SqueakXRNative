Class {
	#name : #XrRecommendedLayerResolutionGetInfoMETA,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrRecommendedLayerResolutionGetInfoMETA class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(layer 'XrCompositionLayerBaseHeader*')
		(predictedDisplayTime 'XrTime')
	)
]
