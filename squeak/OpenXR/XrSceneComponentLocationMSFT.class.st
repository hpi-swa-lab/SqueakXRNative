Class {
	#name : #XrSceneComponentLocationMSFT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{ #category : #'as yet unclassified' }
XrSceneComponentLocationMSFT class >> fields [

	^ #(
		(flags 'XrSpaceLocationFlags')
		(pose 'XrPosef')
	)
]
