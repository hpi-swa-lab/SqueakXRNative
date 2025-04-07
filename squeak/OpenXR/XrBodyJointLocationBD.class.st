Class {
	#name : #XrBodyJointLocationBD,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrBodyJointLocationBD class >> fields [

	^ #(
		(locationFlags 'XrSpaceLocationFlags')
		(pose 'XrPosef')
	)
]
