Class {
	#name : #XrEyeGazesFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{ #category : #'as yet unclassified' }
XrEyeGazesFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(gaze 'XrEyeGazeFB[2]')
		(time 'XrTime')
	)
]
