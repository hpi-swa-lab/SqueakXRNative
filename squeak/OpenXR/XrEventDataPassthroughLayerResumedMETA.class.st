Class {
	#name : #XrEventDataPassthroughLayerResumedMETA,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-6-Generated'
}

{ #category : #'as yet unclassified' }
XrEventDataPassthroughLayerResumedMETA class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(layer 'XrPassthroughLayerFB')
	)
]
