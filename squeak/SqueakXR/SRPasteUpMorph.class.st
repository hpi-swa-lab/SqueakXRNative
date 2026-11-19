Class {
	#name : #SRPasteUpMorph,
	#superclass : #PasteUpMorph,
	#category : #'SqueakXR-Morphic'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MCPServer (jl) 11/18/2026 18:56'
}
SRPasteUpMorph >> addedMorph: aMorph [
	| world |
	world := self currentXRWorld ifNil: [^ self].
	(SRIsAddingMorphsToWorldVariable value
		and: [aMorph shouldBeInMorphPanel]
		and: [aMorph isInMorphPanel not]) ifFalse: [^ self].
	world addChild: (
		SRMorphPanel new
			morph: aMorph;
			globalTransform: (self panelTransformFor: aMorph in: world)).
]

{
	#category : #'dropping/grabbing',
	#'squeak_changestamp' : 'MCPServer 8/10/2026 13:55'
}
SRPasteUpMorph >> allowsMorphGrabbing [
	^false
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 2/16/2026 17:34'
}
SRPasteUpMorph >> beWorldForProject: aProject [

	self privateOwner: nil.
	worldState := SRWorldState new.
	self addHand: HandMorph new.
	self setProperty: #automaticPhraseExpansion toValue: true.
	self setProperty: #optimumExtentFromAuthor toValue: Display extent.
	self startSteppingSubmorphsOf: self
]

{
	#category : #'pop-up menus',
	#'squeak_changestamp' : 'MCPServer (jl) 11/18/2026 18:51'
}
SRPasteUpMorph >> dismissEventFor: aMenu [
	| hand |
	hand := self hands
		detect: [:each | each mouseFocus == aMenu]
		ifNone: [self primaryHand].
	^ MouseButtonEvent new
		setType: #mouseDown
		position: hand position
		which: 0
		buttons: 0
		nClicks: 0
		hand: hand
		stamp: Sensor eventTimeNow
]

{
	#category : #'pop-up menus',
	#'squeak_changestamp' : 'MCPServer (jl) 11/18/2026 18:51'
}
SRPasteUpMorph >> dismissPopUpMenusExcept: aMorphOrNil [
	"An XR click goes straight to the morph of the panel it hits. A pop-up menu
	learns of a click outside it only through the hand's mouse focus, so it never would."
	| kept |
	kept := self popUpRootOf: aMorphOrNil.
	(self submorphs select: [:each |
		(each isKindOf: MenuMorph)
			and: [each stayUp not
			and: [kept isNil or: [(self popUpRootOf: each) ~~ kept]]]])
				do: [:menu |
					"Closing a submenu closes its parents, which may be later in the list."
					menu owner ifNotNil: [menu deleteIfPopUp: (self dismissEventFor: menu)]].
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 2/16/2026 17:31'
}
SRPasteUpMorph >> invalidRect: damageRect from: aMorph [

	self isWorldMorph
		ifTrue: [worldState recordDamagedRect: damageRect from: aMorph].
	^super invalidRect: damageRect from: aMorph
]

{
	#category : #'dropping/grabbing',
	#'squeak_changestamp' : 'MCPServer 8/10/2026 13:55'
}
SRPasteUpMorph >> morphToGrab: event [
	^ self allowsMorphGrabbing
		ifTrue: [super morphToGrab: event]
		ifFalse: [nil]
]

{
	#category : #'pop-up menus',
	#'squeak_changestamp' : 'MCPServer (jl) 11/18/2026 18:56'
}
SRPasteUpMorph >> panelOfParentMenuOf: aMorph in: anXRWorld [
	| parentMenu |
	(aMorph isKindOf: MenuMorph) ifFalse: [^ nil].
	parentMenu := aMorph popUpOwner ifNil: [^ nil] ifNotNil: [:item | item owner].
	parentMenu ifNil: [^ nil].
	anXRWorld allDo: [:each |
		(each isMorphPanel and: [each morph == parentMenu]) ifTrue: [^ each]].
	^ nil
]

{
	#category : #'pop-up menus',
	#'squeak_changestamp' : 'MCPServer (jl) 11/18/2026 18:56'
}
SRPasteUpMorph >> panelTransformFor: aMorph in: anXRWorld [
	"A pop-up menu opens where the clicking hand is, as the XR menus do; anything
	else, a window opened by a click included, would be in the way there."
	| camera hand position |
	(self panelOfParentMenuOf: aMorph in: anXRWorld) ifNotNil: [:parentPanel |
		^ self transformFor: aMorph besideMenuIn: parentPanel].
	camera := anXRWorld camera.
	hand := SRClickingHandVariable value.
	position := ((aMorph isKindOf: MenuMorph) and: [hand notNil and: [anXRWorld avatar notNil]])
		ifTrue: [anXRWorld avatar menuPlacementPositionForHand: hand]
		ifFalse: [camera globalTranslation + (camera forward * 1.6m)].
	^ Matrix4x4
		objectLookAt: camera globalTranslation
		from: position
		up: Vector3 up
]

{
	#category : #'pop-up menus',
	#'squeak_changestamp' : 'MCPServer (jl) 11/18/2026 18:51'
}
SRPasteUpMorph >> popUpRootOf: aMorphOrNil [
	| each root |
	each := aMorphOrNil.
	[each isKindOf: MenuMorph] whileTrue: [
		root := each.
		each := each popUpOwner ifNotNil: [:item | item owner]].
	^ root
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 15:24'
}
SRPasteUpMorph >> removedMorph: aMorph [

	| world |
	world := self currentXRWorld ifNil: [^ self].
	world morphicWorld == self ifFalse: [^ self].
	aMorph isInMorphPanel ifTrue: [
		world allDescendantsSelect: [:obj |
				obj isMorphPanel and: [obj morph = aMorph]]
			thenDo: [:panel |
				panel removeMorph.
				world removeChild: panel]].
]

{
	#category : #'pop-up menus',
	#'squeak_changestamp' : 'MCPServer (jl) 11/18/2026 18:56'
}
SRPasteUpMorph >> transformFor: aSubmenu besideMenuIn: aPanel [
	"Squeak has already put the submenu beside its item in 2D; the same offset on
	the parent's plane keeps that layout, a little in front so the two do not z-fight."
	| onPlane |
	onPlane := aPanel globalPointForMorphPoint: aSubmenu center.
	^ (Matrix4x4 withOffset: onPlane + (aPanel forward * 5mm) - aPanel globalTranslation)
		* aPanel globalTransform
]
