Class {
	#name : #SRHighlightTargetsAction,
	#superclass : #SRHandAction,
	#category : #'SqueakXR-Input'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/19/2026 14:19'
}
SRHighlightTargetsAction >> perform: inputState [

	self hand cursor intersections do: [:inter |
		inter object ifNotNil: 
		[:obj | obj addHighlight: self hand color]
	].

	^ true	
]
