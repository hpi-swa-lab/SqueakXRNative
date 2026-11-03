Class {
	#name : #XrFoveationEyeTrackedStateMETA,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrFoveationEyeTrackedStateMETA class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(foveationCenter 'XrVector2f[2]')
		(flags 'XrFoveationEyeTrackedStateFlagsMETA')
	)
]
