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
	#'squeak_changestamp' : 'MCPServer 8/3/2026 15:44'
}
Morph >> setInMorphPanel: aBoolean [
	"Sticky for as long as I am shown in a panel. #isSticky is Morphic's own
	'do not pick me up' flag and every grab initiator honours it --
	SystemWindow>>startDragFromLabel:, PasteUpMorph>>mouseDown:,
	MenuMorph>>mouseDown:, BooklikeMorph>>move -- so this needs no override of
	any base method. Being grabbed would pull me out of the XR world into the
	hand, firing removedMorph: and tearing down the SRMorphPanel that renders me.
	Moving happens in 3D instead, by dragging the panel.

	Paired: SRMorphPanel>>morph: sets it, SRMorphPanel>>removeMorph clears it."

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
