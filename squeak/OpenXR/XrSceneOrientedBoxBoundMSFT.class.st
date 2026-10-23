Class {
	#name : #XrSceneOrientedBoxBoundMSFT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrSceneOrientedBoxBoundMSFT class >> fields [

	^ #(
		(pose 'XrPosef')
		(extents 'XrVector3f')
	)
]
