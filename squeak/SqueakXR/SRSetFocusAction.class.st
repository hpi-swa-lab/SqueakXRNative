Class {
	#name : #SRSetFocusAction,
	#superclass : #SRHandAction,
	#category : #'SqueakXR-Input'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/19/2026 15:03'
}
SRSetFocusAction >> perform: inputState [

	self hand cursor target ifNotNil: [:inter |
		self hand cursor focusPoint: inter point
	].

	^ true
]
