Class {
	#name : #XrPerformanceMetricsCounterMETA,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrPerformanceMetricsCounterMETA class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(counterFlags 'XrPerformanceMetricsCounterFlagsMETA')
		(counterUnit 'XrPerformanceMetricsCounterUnitMETA')
		(uintValue 'uint32_t')
		(floatValue 'float')
	)
]
