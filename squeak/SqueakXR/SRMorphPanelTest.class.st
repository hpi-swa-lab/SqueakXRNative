Class {
	#name : #SRMorphPanelTest,
	#superclass : #TestCase,
	#instVars : [
		'xrWorld',
		'previousXRWorld',
		'morphicWorld',
		'avatar'
	],
	#category : #'SqueakXR-Tests-Morphic'
}

{
	#category : #support,
	#'squeak_changestamp' : 'jl-MCPServer 11/20/2026 12:50'
}
SRMorphPanelTest >> aim: aHand at: anObject [
	aHand selectTargetsFrom: {SRIntersectionResult new object: anObject; point: 0 @ 0 @ 0; distance: 1m; yourself}.
]

{
	#category : #running,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 15:24'
}
SRMorphPanelTest >> enterNewMorphicProject [

	xrWorld project: SRDummyMorphicProject new.
	morphicWorld := xrWorld morphicWorld.
	xrWorld morphicProjectEntered
]

{
	#category : #helpers,
	#'squeak_changestamp' : 'jl-MCPServer 11/20/2026 11:13'
}
SRMorphPanelTest >> openTextInMorphic [
	"SystemWindow>>beKeyWindow needs a viewBox, which the test world only has once it is set."
	| window text |
	morphicWorld viewBox: (0 @ 0 extent: 800 @ 600).
	window := self openWindowInMorphic.
	text := TextMorph new contents: 'hello world'; yourself.
	window addMorph: text frame: (0 @ 0 corner: 1 @ 1).
	window fullBounds.
	^ text
]

{
	#category : #helpers,
	#'squeak_changestamp' : 'MCPServer 8/10/2026 15:15'
}
SRMorphPanelTest >> openWindowInMorphic [
	"A SystemWindow is one of the Morphs that answer #shouldBeInMorphPanel."

	| window |
	window := SystemWindow new.
	morphicWorld addMorph: window.
	^ window
]

{
	#category : #running,
	#'squeak_changestamp' : 'MCPServer (jl) 11/18/2026 18:56'
}
SRMorphPanelTest >> panelOf: aMorph [
	^ self panels detect: [:each | each morph == aMorph]
]

{
	#category : #helpers,
	#'squeak_changestamp' : 'MCPServer 8/10/2026 15:15'
}
SRMorphPanelTest >> panels [

	^ xrWorld children select: [:each | each isMorphPanel]
]

{
	#category : #running,
	#'squeak_changestamp' : 'leo-MCPServer 11/20/2026 19:10'
}
SRMorphPanelTest >> setUp [

	super setUp.
	previousXRWorld := SRWorld current.
	xrWorld := SRWorld new.
	avatar := SRAvatar new.
	xrWorld addChild: avatar.
	xrWorld project: SRDummyMorphicProject new.
	SRWorld current: xrWorld.
	morphicWorld := xrWorld morphicWorld
]

{
	#category : #running,
	#'squeak_changestamp' : 'MCPServer 8/10/2026 15:16'
}
SRMorphPanelTest >> tearDown [

	"Delete before restoring: SRPasteUpMorph>>removedMorph: needs the XR world."
	morphicWorld ifNotNil: [morphicWorld submorphs do: [:each | each delete]].
	SRWorld current: previousXRWorld.
	super tearDown
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (jl) 11/18/2026 18:51'
}
SRMorphPanelTest >> testAClickElsewhereDismissesAPopUpMenu [
	| menu sticky |
	menu := MenuMorph new.
	menu add: 'one' action: #yourself.
	sticky := MenuMorph new.
	sticky add: 'two' action: #yourself; stayUp: true.
	morphicWorld addMorphFront: menu; addMorphFront: sticky.
	morphicWorld dismissPopUpMenusExcept: menu.
	self assert: menu owner == morphicWorld.
	morphicWorld dismissPopUpMenusExcept: nil.
	self
		assert: menu owner isNil;
		assert: sticky owner == morphicWorld.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (jl) 11/18/2026 18:51'
}
SRMorphPanelTest >> testAClickInACascadeKeepsTheWholeCascade [
	| parent item sub other |
	parent := MenuMorph new.
	parent add: 'more' action: #yourself.
	item := parent items first.
	sub := MenuMorph new.
	sub add: 'leaf' action: #yourself; popUpOwner: item.
	other := MenuMorph new.
	other add: 'elsewhere' action: #yourself.
	morphicWorld addMorphFront: parent; addMorphFront: sub; addMorphFront: other.
	morphicWorld dismissPopUpMenusExcept: parent.
	self
		assert: parent owner == morphicWorld;
		assert: sub owner == morphicWorld;
		assert: other owner isNil.
	morphicWorld dismissPopUpMenusExcept: nil.
	self
		assert: parent owner isNil;
		assert: sub owner isNil.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'jl-MCPServer 11/20/2026 11:17'
}
SRMorphPanelTest >> testAGrabbedPanelFollowsTheHand [
	| panel target |
	panel := SRMorphPanel new.
	target := SRObject new.
	target position: 1m @ 2m @ -3m.
	panel dragTo: target globalTransform.
	self assert: target globalTransform equals: panel globalTransform.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/20/2026 19:10'
}
SRMorphPanelTest >> testAPopUpMenuOpensAtTheClickingHand [
	| hand menu |
	hand := avatar rightHand.
	menu := MenuMorph new.
	menu add: 'one' action: #yourself.
	SRClickingHandVariable value: hand during: [morphicWorld addMorphFront: menu].
	self assert: ((self panelOf: menu) globalTranslation
		- (avatar menuPlacementPositionForHand: hand)) length < 1mm.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'jl-MCPServer 11/20/2026 11:17'
}
SRMorphPanelTest >> testAPressHoldsTheMouseFocusUntilTheRelease [
	| text panel point hand |
	text := self openTextInMorphic.
	panel := self panelOf: text owner.
	hand := morphicWorld primaryHand.
	point := (text paragraph characterBlockForIndex: 1) center.
	panel mouseDownAt: point button: MouseButtonEvent redButton.
	self assert: text equals: hand mouseFocus.
	panel mouseUpAt: point.
	self assert: hand mouseFocus isNil.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'jl-MCPServer 11/20/2026 11:24'
}
SRMorphPanelTest >> testAPressInsideASelectionStartsNoDragAndDrop [
	| text panel hand |
	text := self openTextInMorphic.
	text dragEnabled: true.
	text editor selectFrom: 1 to: 5.
	panel := self panelOf: text owner.
	hand := morphicWorld primaryHand.
	panel mouseDownAt: (text paragraph characterBlockForIndex: 2) center button: MouseButtonEvent redButton.
	self assert: (hand instVarNamed: 'mouseClickState') isNil.
	panel mouseUpAt: (text paragraph characterBlockForIndex: 2) center.
	self assert: hand submorphs isEmpty.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'jl-MCPServer 11/20/2026 12:35'
}
SRMorphPanelTest >> testARightPressOpensTheMorphicMenu [
	| window pane panel menus |
	morphicWorld viewBox: (0 @ 0 extent: 800 @ 600).
	window := self openWindowInMorphic.
	pane := PluggableTextMorph
		on: Workspace new
		text: #contents
		accept: #acceptContents:
		readSelection: nil
		menu: #codePaneMenu:shifted:.
	window addMorph: pane frame: (0 @ 0 corner: 1 @ 1).
	window fullBounds.
	panel := self panelOf: window.
	morphicWorld becomeActiveDuring: [
		panel mouseDownAt: pane center button: MouseButtonEvent yellowButton.
		panel mouseUpAt: pane center].
	menus := morphicWorld submorphs select: [:each | each isKindOf: MenuMorph].
	self assert: 1 equals: menus size.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/20/2026 19:10'
}
SRMorphPanelTest >> testASubmenuOpensBesideItsParent [
	| parent sub parentPanel subPanel seam |
	parent := MenuMorph new.
	parent add: 'more' action: #yourself.
	SRClickingHandVariable value: avatar rightHand during: [
		morphicWorld addMorphFront: parent].
	sub := MenuMorph new.
	sub add: 'leaf' action: #yourself; popUpOwner: parent items first.
	sub position: parent topRight.
	morphicWorld addMorphFront: sub.
	parentPanel := self panelOf: parent.
	subPanel := self panelOf: sub.
	seam := (subPanel globalPointForMorphPoint: sub leftCenter)
		- (parentPanel globalPointForMorphPoint: parent rightCenter).
	self
		assert: ((seam - (parentPanel forward * 5mm)) length) < 1mm;
		assert: ((subPanel forward - parentPanel forward) length) < 0.001.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/20/2026 19:10'
}
SRMorphPanelTest >> testAWindowOpenedByAClickKeepsItsDistance [
	| camera window |
	camera := avatar camera.
	window := SystemWindow new.
	SRClickingHandVariable value: avatar rightHand during: [
		morphicWorld addMorphFront: window].
	self assert: (((self panelOf: window) globalTranslation
		- camera globalTranslation) length - 1.6m) abs < 1mm.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (jl) 11/18/2026 19:12'
}
SRMorphPanelTest >> testArrowKeysReachTheMenuHoldingTheKeyboardFocus [
	| window menu event |
	window := self openWindowInMorphic.
	menu := MenuMorph new.
	menu add: 'one' action: #yourself; add: 'two' action: #yourself.
	morphicWorld addMorphFront: menu.
	morphicWorld primaryHand newKeyboardFocus: menu.
	event := KeyboardEvent new
		setType: #keystroke
		buttons: 0
		position: window center
		keyValue: Character arrowDown asInteger
		keyCode: Character arrowDown asInteger
		hand: morphicWorld primaryHand
		stamp: 0.
	(self panelOf: window) deliverKeyboardEvent: event.
	self assert: menu selectedItem notNil.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (jl) 11/18/2026 18:46'
}
SRMorphPanelTest >> testControlClickIsTheRightClick [
	| panel trigger other |
	panel := SRMorphPanel new.
	trigger := SRInputEventButton new button: #trigger; pressed: true; yourself.
	other := SRInputEventButton new button: #squeeze; pressed: true; yourself.
	self
		assert: MouseButtonEvent redButton
			equals: (panel morphicButtonFor: trigger controlDown: false);
		assert: MouseButtonEvent yellowButton
			equals: (panel morphicButtonFor: trigger controlDown: true);
		assert: (panel morphicButtonFor: other controlDown: true) isNil.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'jl-MCPServer 11/20/2026 11:17'
}
SRMorphPanelTest >> testDraggingAcrossTextSelectsIt [
	| text panel start stop |
	text := self openTextInMorphic.
	panel := self panelOf: text owner.
	start := (text paragraph characterBlockForIndex: 1) center.
	stop := (text paragraph characterBlockForIndex: 6) leftCenter.
	panel mouseDownAt: start button: MouseButtonEvent redButton.
	panel pointerMovedTo: stop.
	panel mouseUpAt: stop.
	self assert: 'hello' equals: text editor selection asString.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 15:24'
}
SRMorphPanelTest >> testEnteringNewMorphicProjectKeepsMorphAlreadyThere [

	| window |
	window := self openWindowInMorphic.

	xrWorld morphicProjectEntered.

	self assert: (morphicWorld submorphs select: [:each | each == window]) size = 1.
	self assert: self panels size = 1
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 15:24'
}
SRMorphPanelTest >> testEnteringNewMorphicProjectMovesPanelMorphThere [

	| window panel |
	window := self openWindowInMorphic.
	panel := self panels first.

	self enterNewMorphicProject.

	self assert: window owner == morphicWorld.
	self assert: panel morph == window.
	self assert: panel world == xrWorld.
	self assert: self panels size = 1
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (jl) 11/16/2026 11:41'
}
SRMorphPanelTest >> testEveryPanelHasItsResizers [

	self assert: SRMorphPanel new resizers size equals: SRResizer corners size.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (jl) 11/18/2026 19:12'
}
SRMorphPanelTest >> testHoveringAMenuItemSelectsIt [
	| menu panel item |
	menu := MenuMorph new.
	menu add: 'one' action: #yourself; add: 'two' action: #yourself.
	morphicWorld addMorphFront: menu.
	menu fullBounds.
	panel := self panelOf: menu.
	item := menu items second.
	panel hoverAt: item center.
	self assert: menu selectedItem == item.
	panel hoverAt: menu items first center.
	self assert: menu selectedItem == menu items first.
	panel hoverAt: nil.
	self assert: (panel instVarNamed: 'hoveredMorphs') isEmpty.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (jl) 11/18/2026 19:13'
}
SRMorphPanelTest >> testHoveringAnItemWithASubmenuOpensItBesideTheMenu [
	| menu sub |
	sub := MenuMorph new.
	sub add: 'leaf' action: #yourself.
	"Never displayed, so it has no view box for Squeak to fit the submenu into."
	morphicWorld viewBox: (0 @ 0 extent: 1600 @ 1200).
	menu := MenuMorph new.
	menu add: 'more' subMenu: sub.
	morphicWorld addMorphFront: menu.
	menu fullBounds.
	(self panelOf: menu) hoverAt: menu items first center.
	self
		assert: sub owner == morphicWorld;
		assert: (self panels anySatisfy: [:each | each morph == sub]).
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MCPServer 8/11/2026 15:31'
}
SRMorphPanelTest >> testMorphInPanel [

	| morph panel |
	morph := Morph new.
	panel := SRMorphPanel new.
	
	self deny: morph isInMorphPanel.
	panel morph: morph.
	self assert: morph isInMorphPanel.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'jl-MCPServer 11/20/2026 12:55'
}
SRMorphPanelTest >> testOnlyPointsOnTheMorphTakeARightClick [
	| window panel |
	window := self openWindowInMorphic.
	panel := self panelOf: window.
	self
		assert: (panel acceptsRightClickAt: (panel globalPointForMorphPoint: window center));
		deny: (panel acceptsRightClickAt: (panel globalPointForMorphPoint: window bottomRight + (20 @ 20))).
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer 8/10/2026 15:15'
}
SRMorphPanelTest >> testOpeningMorphInMorphicCreatesPanelInXR [

	| window |
	self assert: self panels isEmpty.
	window := self openWindowInMorphic.

	self assert: self panels size = 1.
	self assert: self panels first morph == window.
	self assert: window isInMorphPanel
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer 8/10/2026 15:15'
}
SRMorphPanelTest >> testRemountingPanelInXRReaddsMorphToMorphic [

	| window panel |
	window := self openWindowInMorphic.
	panel := self panels first.
	panel remove.

	xrWorld addChild: panel.

	self assert: panel morph == window.
	self assert: panel detachedMorph isNil.
	self assert: (morphicWorld submorphs includes: window).
	self assert: window owner == morphicWorld.
	self assert: window isInMorphPanel.
	"The remounted Morph must not make SRPasteUpMorph>>addedMorph: build a second panel."
	self assert: self panels size = 1
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer 8/11/2026 15:31'
}
SRMorphPanelTest >> testRemountingPanelWithoutMorphIsHarmless [

	| panel |
	panel := SRMorphPanel new.
	xrWorld addChild: panel.
	panel remove.

	xrWorld addChild: panel.

	self assert: panel morph isNil.
	self assert: panel detachedMorph isNil
]

{
	#category : #tests,
	#'squeak_changestamp' : 'jl 8/10/2026 17:49'
}
SRMorphPanelTest >> testRemovingAncestorDetachesNestedPanelMorph [
	
	| window panel group |
	window := self openWindowInMorphic.
	panel := self panels first.
	group := SRObject new.
	xrWorld addChild: group.
	group addChild: panel.

	xrWorld removeChild: group.

	self assert: panel parent == group.
	self assert: panel morph isNil.
	self assert: panel detachedMorph == window.
	self deny: (morphicWorld submorphs includes: window).

	xrWorld addChild: group.

	self assert: panel morph == window.
	self assert: panel detachedMorph isNil.
	self assert: (morphicWorld submorphs includes: window)
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 15:24'
}
SRMorphPanelTest >> testRemovingMorphFromStaleMorphicWorldKeepsPanel [

	| window |
	window := self openWindowInMorphic.
	xrWorld project: SRDummyMorphicProject new.

	window delete.

	self assert: self panels size = 1
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer 8/10/2026 15:15'
}
SRMorphPanelTest >> testRemovingPanelInXRRemovesMorphFromMorphic [

	| window panel |
	window := self openWindowInMorphic.
	panel := self panels first.

	panel remove.

	self assert: self panels isEmpty.
	self assert: panel morph isNil.
	self deny: (morphicWorld submorphs includes: window).
	self assert: window owner isNil.
	self deny: window isInMorphPanel.
	self assert: panel detachedMorph == window
]

{
	#category : #tests,
	#'squeak_changestamp' : 'jl 8/10/2026 17:49'
}
SRMorphPanelTest >> testReparentingPanelInsideWorldKeepsMorphInMorphic [

	| window panel group |
	window := self openWindowInMorphic.
	panel := self panels first.
	group := SRObject new.
	xrWorld addChild: group.

	group addChild: panel.

	self assert: panel parent == group.
	self assert: panel morph == window.
	self assert: panel detachedMorph isNil.
	self assert: (morphicWorld submorphs includes: window).
	self assert: window owner == morphicWorld
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (jl) 11/16/2026 13:51'
}
SRMorphPanelTest >> testResizingTheMorphInMorphicResizesThePanel [

	| morph panel |
	morph := Morph new extent: 400 @ 300; yourself.
	panel := SRMorphPanel new morph: morph.
	morph extent: 800 @ 600.
	morph changed: #worldDrawn with: morph bounds.
	self assert: (panel resizerAt: #bottomRight) position x * panel pixelsPerMeter >= 400.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/20/2026 19:10'
}
SRMorphPanelTest >> testTheBButtonBesideTheMorphKeepsTheXRMenu [
	"Off the morph, e.g. on a resizer, so the right click queues nothing in the live UI process."
	| window panel hand |
	window := self openWindowInMorphic.
	panel := self panelOf: window.
	hand := avatar rightHand.
	hand selectTargetsFrom: {SRIntersectionResult new
		object: (panel children detect: [:each | each isKindOf: SRPlane]);
		point: (panel globalPointForMorphPoint: window bottomRight + (20 @ 20));
		distance: 1m;
		yourself}.
	avatar openMenuForHand: hand.
	self assert: avatar contextMenu notNil.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/20/2026 19:10'
}
SRMorphPanelTest >> testTheBButtonElsewhereKeepsTheXRMenu [
	| hand |
	hand := avatar rightHand.
	self aim: hand at: SRCube new.
	avatar openMenuForHand: hand.
	self assert: avatar contextMenu notNil.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (jl) 11/16/2026 13:23'
}
SRMorphPanelTest >> testThePanelSizeDoesNotGrowWithTheDesktopScaleFactor [

	| morph panel |
	morph := Morph new extent: (1000 * RealEstateAgent scaleFactor) @ 500; yourself.
	panel := SRMorphPanel new morph: morph.
	self assert: (morph width / panel pixelsPerMeter closeTo: 1000 / SRMorphPanel pixelsPerMeter).
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/20/2026 19:10'
}
SRMorphPanelTest >> testTheRayFindsThePanelThroughItsPlane [
	| panel plane hand |
	panel := self panelOf: self openWindowInMorphic.
	plane := panel children detect: [:each | each isKindOf: SRPlane].
	hand := avatar rightHand.
	self aim: hand at: plane.
	self assert: hand morphPanelUnderRay == panel.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (jl) 11/13/2026 15:45'
}
SRMorphPanelTest >> testWheelNotchesBecomeMorphicScrollUnits [
	| panel up down |
	panel := SRMorphPanel new.
	panel morph: Morph new.
	up := panel mouseWheelEventFor: 1.0 at: 10 @ 20.
	down := panel mouseWheelEventFor: -0.5 at: 10 @ 20.
	self
		assert: up isWheelUp;
		assert: 0 @ 120 equals: up wheelDelta;
		assert: 10 @ 20 equals: up position;
		assert: down isWheelDown;
		assert: 0 @ -60 equals: down wheelDelta.
]
