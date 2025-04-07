Class {
	#name : #XrSpaceLocation,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{ #category : #'as yet unclassified' }
XrSpaceLocation class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(locationFlags 'XrSpaceLocationFlags')
		(pose 'XrPosef')
	)
]
