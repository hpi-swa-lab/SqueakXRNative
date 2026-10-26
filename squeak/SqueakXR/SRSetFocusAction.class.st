Class {
	#name : #SRSetFocusAction,
	#superclass : #SRHandAction,
	#category : #'SqueakXR-Halo'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/26/2026 15:58'
}
SRSetFocusAction >> run: inputState [

	self hand cursor focusPoint: (self hand cursorPoint).
	^ true
]
