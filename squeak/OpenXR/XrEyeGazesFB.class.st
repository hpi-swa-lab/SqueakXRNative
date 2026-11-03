Class {
	#name : #XrEyeGazesFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrEyeGazesFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(gaze 'XrEyeGazeFB[2]')
		(time 'XrTime')
	)
]
