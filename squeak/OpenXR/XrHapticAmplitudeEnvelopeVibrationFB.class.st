Class {
	#name : #XrHapticAmplitudeEnvelopeVibrationFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{ #category : #'as yet unclassified' }
XrHapticAmplitudeEnvelopeVibrationFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(duration 'XrDuration')
		(amplitudeCount 'uint32_t')
		(amplitudes 'float*')
	)
]
