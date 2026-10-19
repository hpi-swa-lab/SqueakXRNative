Class {
	#name : #SRHighlightTargetsAction,
	#superclass : #SRHandAction,
	#category : #'SqueakXR-Halo'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/19/2026 16:02'
}
SRHighlightTargetsAction >> perform: inputState [

	self hand cursorTarget ifNotNil: [:target |
		target addHighlight: self hand color
	].

	^ true	
]
