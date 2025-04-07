Class {
	#name : #XrViewConfigurationDepthRangeEXT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{ #category : #'as yet unclassified' }
XrViewConfigurationDepthRangeEXT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(recommendedNearZ 'float')
		(minNearZ 'float')
		(recommendedFarZ 'float')
		(maxFarZ 'float')
	)
]
