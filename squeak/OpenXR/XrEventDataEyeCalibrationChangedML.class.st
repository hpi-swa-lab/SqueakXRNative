Class {
	#name : #XrEventDataEyeCalibrationChangedML,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{ #category : #'as yet unclassified' }
XrEventDataEyeCalibrationChangedML class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(status 'XrEyeCalibrationStatusML')
	)
]
