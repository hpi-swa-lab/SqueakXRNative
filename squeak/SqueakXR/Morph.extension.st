Extension { #name : #Morph }

{
	#category : #'*SqueakXR-morphic',
	#'squeak_changestamp' : 'lege 2/17/2026 18:45'
}
Morph >> isInMorphPanel [

	^ self valueOfProperty: #isInMorphPanel ifAbsent: [false]
]

{
	#category : #'*SqueakXR-morphic',
	#'squeak_changestamp' : 'lege 3/16/2026 17:39'
}
Morph >> lastPanelPosition [

	^ self valueOfProperty: #lastPanelPosition
]

{
	#category : #'*SqueakXR-morphic',
	#'squeak_changestamp' : 'lege 3/16/2026 17:38'
}
Morph >> lastPanelPosition: aVector3 [

	^ self setProperty: #lastPanelPosition toValue: aVector3
]

{
	#category : #'*SqueakXR-morphic',
	#'squeak_changestamp' : 'lege 4/8/2026 17:55'
}
Morph >> openInXRWorld [

	^ SRMorphPanel new morph: self; openInWorld; yourself
]

{
	#category : #'*SqueakXR-morphic',
	#'squeak_changestamp' : 'MCPServer 8/3/2026 15:54'
}
Morph >> setInMorphPanel: aBoolean [
	"Sticky while in a panel. #isSticky is the flag every grab initiator honours
	(SystemWindow>>startDragFromLabel:, PasteUpMorph>>mouseDown: ...), so no base
	method needs overriding. A grab would pull me out of the XR world into the hand,
	firing removedMorph: and tearing down the panel; move the panel in 3D instead."

	self sticky: aBoolean.
	^ self setProperty: #isInMorphPanel toValue: aBoolean
]

{
	#category : #'*SqueakXR-morphic',
	#'squeak_changestamp' : 'lege 3/16/2026 17:24'
}
Morph >> setIsInMorphPanel [

	^ self setInMorphPanel: true
]

{
	#category : #'*SqueakXR-morphic',
	#'squeak_changestamp' : 'lege 3/19/2026 15:20'
}
Morph >> shouldBeInMorphPanel [

	^ false
]

{
	#category : #'*SqueakXR-morphic',
	#'squeak_changestamp' : 'lege 3/11/2026 17:55'
}
Morph >> worldDrewIn: aRectangle [

	self isInMorphPanel ifFalse: [^ self].
	self changed: #worldDrawn with: aRectangle
	
]
