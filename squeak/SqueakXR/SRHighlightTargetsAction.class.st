Class {
	#name : #SRHighlightTargetsAction,
	#superclass : #SRHandAction,
	#category : #'SqueakXR-Halo'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/26/2026 15:58'
}
SRHighlightTargetsAction >> run: inputState [

	self hand cursorTarget ifNotNil: [:target |
		target addHighlight: self hand color
	].

	^ true	
]
