Class {
	#name : #XrSpaceLocationData,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{ #category : #'as yet unclassified' }
XrSpaceLocationData class >> fields [

	^ #(
		(locationFlags 'XrSpaceLocationFlags')
		(pose 'XrPosef')
	)
]
