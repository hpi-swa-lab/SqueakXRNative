Class {
	#name : #XrHapticAmplitudeEnvelopeVibrationFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrHapticAmplitudeEnvelopeVibrationFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(duration 'XrDuration')
		(amplitudeCount 'uint32_t')
		(amplitudes 'float*')
	)
]
