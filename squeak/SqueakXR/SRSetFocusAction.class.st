Class {
	#name : #SRSetFocusAction,
	#superclass : #SRHandAction,
	#category : #'SqueakXR-Halo'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/19/2026 15:59'
}
SRSetFocusAction >> perform: inputState [

	self hand cursor focusPoint: (self hand cursorPoint).
	^ true
]
