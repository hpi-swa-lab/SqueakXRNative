Class {
	#name : #XrKeyboardTrackingDescriptionFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrKeyboardTrackingDescriptionFB class >> fields [

	^ #(
		(trackedKeyboardId 'uint64_t')
		(size 'XrVector3f')
		(flags 'XrKeyboardTrackingFlagsFB')
		(name 'char[128]')
	)
]
