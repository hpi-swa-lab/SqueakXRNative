Class {
	#name : #XrUserCalibrationEnableEventsInfoML,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{ #category : #'as yet unclassified' }
XrUserCalibrationEnableEventsInfoML class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(enabled 'XrBool32')
	)
]
