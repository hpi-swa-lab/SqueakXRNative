Class {
	#name : #XrFoveationEyeTrackedStateMETA,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{ #category : #'as yet unclassified' }
XrFoveationEyeTrackedStateMETA class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(foveationCenter 'XrVector2f[2]')
		(flags 'XrFoveationEyeTrackedStateFlagsMETA')
	)
]
