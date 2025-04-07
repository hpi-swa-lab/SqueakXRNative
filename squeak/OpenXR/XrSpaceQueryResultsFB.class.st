Class {
	#name : #XrSpaceQueryResultsFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{ #category : #'as yet unclassified' }
XrSpaceQueryResultsFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(resultCapacityInput 'uint32_t')
		(resultCountOutput 'uint32_t')
		(results 'XrSpaceQueryResultFB*')
	)
]
