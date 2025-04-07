Class {
	#name : #XrSceneOrientedBoxBoundMSFT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{ #category : #'as yet unclassified' }
XrSceneOrientedBoxBoundMSFT class >> fields [

	^ #(
		(pose 'XrPosef')
		(extents 'XrVector3f')
	)
]
