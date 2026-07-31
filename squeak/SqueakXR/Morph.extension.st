Extension { #name : #Morph }

{
	#category : #'*SqueakXR-dropping/grabbing-override',
	#'squeak_changestamp' : 'MCPServer 7/31/2026 13:41'
}
Morph >> aboutToBeGrabbedBy: aHand [
	"The receiver is being grabbed by a hand.
	Perform necessary adjustments (if any) and return the actual morph
	that should be added to the hand."
	| extentToHandToHand cmd |
	(self world ifNil: [true] ifNotNil: [:w | w allowsMorphGrabbing])
		ifFalse: [^nil].
	self formerOwner: owner.
	self formerPosition: self position.
	cmd := self undoGrabCommand.
	cmd ifNotNil:[self setProperty: #undoGrabCommand toValue: cmd].
	(extentToHandToHand := self valueOfProperty: #expandedExtent)
			ifNotNil:
				[self removeProperty: #expandedExtent.
				self extent: extentToHandToHand].
	^self "Grab me"
]

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
	#'squeak_changestamp' : 'lege 3/16/2026 17:24'
}
Morph >> setInMorphPanel: aBoolean [

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
