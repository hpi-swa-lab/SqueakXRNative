Class {
	#name : #XrPerformanceMetricsStateMETA,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrPerformanceMetricsStateMETA class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(enabled 'XrBool32')
	)
]
