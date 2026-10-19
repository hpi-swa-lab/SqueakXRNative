Class {
	#name : #SRSetFocusAction,
	#superclass : #SRHandAction,
	#category : #'SqueakXR-Input'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/19/2026 15:16'
}
SRSetFocusAction >> perform: inputState [

	| first |
	first := self hand cursor firstIntersection.
	self hand cursor focusPoint: (first ifNotNil: [:inter | inter point ]).

	^ true
]
