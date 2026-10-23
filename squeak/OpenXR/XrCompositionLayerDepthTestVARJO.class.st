Class {
	#name : #XrCompositionLayerDepthTestVARJO,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrCompositionLayerDepthTestVARJO class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(depthTestRangeNearZ 'float')
		(depthTestRangeFarZ 'float')
	)
]
