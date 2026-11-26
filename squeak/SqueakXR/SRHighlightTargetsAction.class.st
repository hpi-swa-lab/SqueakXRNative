Class {
	#name : #SRHighlightTargetsAction,
	#superclass : #SRHandAction,
	#category : #'SqueakXR-Halo'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'jl-MCPServer 11/25/2026 17:04'
}
SRHighlightTargetsAction >> run: inputState [
	"The floor makes the world the target of every ray at it, and highlighting the world outlines all it holds."
	self hand cursorTarget ifNotNil: [:target |
		target isWorldObject ifFalse: [target addHighlight: self hand color]].
	^ true
]
