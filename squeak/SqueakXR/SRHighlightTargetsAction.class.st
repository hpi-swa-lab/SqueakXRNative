Class {
	#name : #SRHighlightTargetsAction,
	#superclass : #SRHandAction,
	#category : #'SqueakXR-Input'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/19/2026 15:20'
}
SRHighlightTargetsAction >> perform: inputState [

	self hand cursor intersections do: [:inter |
		inter object ifNotNil: 
		[:obj | obj addHighlight: Color gray]
	].
	self hand cursor firstIntersection ifNotNil: [:inter |
		inter object addHighlight: self hand color
	].

	^ true	
]
