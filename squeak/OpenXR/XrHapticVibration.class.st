Class {
	#name : #XrHapticVibration,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{ #category : #'as yet unclassified' }
XrHapticVibration class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(duration 'XrDuration')
		(frequency 'float')
		(amplitude 'float')
	)
]
