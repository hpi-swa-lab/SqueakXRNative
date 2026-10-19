Class {
	#name : #SRSetFocusAction,
	#superclass : #SRHandAction,
	#category : #'SqueakXR-Input'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/19/2026 14:19'
}
SRSetFocusAction >> perform: inputState [

	| cursor |
	cursor := self hand cursor.
	cursor intersections ifNotEmpty: [:intersections |
		cursor focusPoint: intersections first point
	] ifEmpty: [
		cursor focusPoint: nil.
	].
	
	^ true
]
