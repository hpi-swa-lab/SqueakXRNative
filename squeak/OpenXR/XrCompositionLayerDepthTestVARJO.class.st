Class {
	#name : #XrCompositionLayerDepthTestVARJO,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrCompositionLayerDepthTestVARJO class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(depthTestRangeNearZ 'float')
		(depthTestRangeFarZ 'float')
	)
]
