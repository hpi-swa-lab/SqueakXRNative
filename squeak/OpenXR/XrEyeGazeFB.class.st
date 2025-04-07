Class {
	#name : #XrEyeGazeFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{ #category : #'as yet unclassified' }
XrEyeGazeFB class >> fields [

	^ #(
		(isValid 'XrBool32')
		(gazePose 'XrPosef')
		(gazeConfidence 'float')
	)
]
