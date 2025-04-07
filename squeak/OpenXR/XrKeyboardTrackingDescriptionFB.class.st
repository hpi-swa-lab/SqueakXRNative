Class {
	#name : #XrKeyboardTrackingDescriptionFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{ #category : #'as yet unclassified' }
XrKeyboardTrackingDescriptionFB class >> fields [

	^ #(
		(trackedKeyboardId 'uint64_t')
		(size 'XrVector3f')
		(flags 'XrKeyboardTrackingFlagsFB')
		(name 'char[128]')
	)
]
