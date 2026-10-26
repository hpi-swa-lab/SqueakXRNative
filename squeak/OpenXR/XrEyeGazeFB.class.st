Class {
	#name : #XrEyeGazeFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrEyeGazeFB class >> fields [

	^ #(
		(isValid 'XrBool32')
		(gazePose 'XrPosef')
		(gazeConfidence 'float')
	)
]
