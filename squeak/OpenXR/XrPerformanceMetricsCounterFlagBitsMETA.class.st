Class {
	#name : #XrPerformanceMetricsCounterFlagBitsMETA,
	#superclass : #ExternalTypeAlias,
	#category : #'OpenXR-Typedefs-Generated'
}

{ #category : #'as yet unclassified' }
XrPerformanceMetricsCounterFlagBitsMETA class >> XR_PERFORMANCE_METRICS_COUNTER_ANY_VALUE_VALID_BIT_META [

	^ self on: (1 bitShift: 0)
]

{ #category : #'as yet unclassified' }
XrPerformanceMetricsCounterFlagBitsMETA class >> XR_PERFORMANCE_METRICS_COUNTER_FLOAT_VALUE_VALID_BIT_META [

	^ self on: (1 bitShift: 2)
]

{ #category : #'as yet unclassified' }
XrPerformanceMetricsCounterFlagBitsMETA class >> XR_PERFORMANCE_METRICS_COUNTER_UINT_VALUE_VALID_BIT_META [

	^ self on: (1 bitShift: 1)
]

{ #category : #'as yet unclassified' }
XrPerformanceMetricsCounterFlagBitsMETA class >> originalTypeName [

    ^ 'long'
]
