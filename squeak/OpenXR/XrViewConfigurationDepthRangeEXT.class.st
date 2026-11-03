Class {
	#name : #XrViewConfigurationDepthRangeEXT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
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
