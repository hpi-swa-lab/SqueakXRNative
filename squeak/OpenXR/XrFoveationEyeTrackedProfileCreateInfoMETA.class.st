Class {
	#name : #XrFoveationEyeTrackedProfileCreateInfoMETA,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{ #category : #'as yet unclassified' }
XrFoveationEyeTrackedProfileCreateInfoMETA class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(flags 'XrFoveationEyeTrackedProfileCreateFlagsMETA')
	)
]
