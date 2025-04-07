Class {
	#name : #XrBodyJointLocationFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{ #category : #'as yet unclassified' }
XrBodyJointLocationFB class >> fields [

	^ #(
		(locationFlags 'XrSpaceLocationFlags')
		(pose 'XrPosef')
	)
]
