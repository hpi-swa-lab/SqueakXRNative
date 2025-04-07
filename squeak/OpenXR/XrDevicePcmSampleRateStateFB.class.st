Class {
	#name : #XrDevicePcmSampleRateStateFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{ #category : #'as yet unclassified' }
XrDevicePcmSampleRateStateFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(sampleRate 'float')
	)
]
