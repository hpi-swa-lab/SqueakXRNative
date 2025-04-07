Class {
	#name : #XrHapticPcmVibrationFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{ #category : #'as yet unclassified' }
XrHapticPcmVibrationFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(bufferSize 'uint32_t')
		(buffer 'float*')
		(sampleRate 'float')
		(append 'XrBool32')
		(samplesConsumed 'uint32_t*')
	)
]
