"
Tests for SRMenu, its submenu cascade and the SRMenuRegistry grouping. The registry singleton is loaded with a known set of entries under #(demo) for the duration of each test.
"
Class {
	#name : #SRMenuTest,
	#superclass : #TestCase,
	#instVars : [
		'savedEntries'
	],
	#classVars : [
		'DemoToggleState'
	],
	#category : #'SqueakXR-Tests-Objects',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #fixture,
	#'squeak_changestamp' : 'MCPServer 8/3/2026 14:41'
}
SRMenuTest class >> demoAction: aMenu target: anObject [
	^ anObject
]

{
	#category : #fixture,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:38'
}
SRMenuTest class >> demoToggle: aMenu target: anObject [
	DemoToggleState := 'on'.
]

{
	#category : #fixture,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:38'
}
SRMenuTest class >> demoToggleLabel [
	^ 'toggle: ' , (DemoToggleState ifNil: ['off']).
]

{
	#category : #fixture,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:38'
}
SRMenuTest >> demoEntries [
	"In the order SRMenuRegistry>>buildRegistry would sort them: by path, then priority."

	^ {
		self entryAt: #(demo) label: 'Alpha' priority: 100.
		self entryAt: #(demo) label: 'Beta' priority: 200.
		self entryAt: #(demo tools) label: 'Paste' priority: 110.
		self entryAt: #(demo tools) label: 'Cut' priority: 120.
		self entryAt: #(demo zoo) label: 'Lion' priority: 400 }
]

{
	#category : #fixture,
	#'squeak_changestamp' : 'MCPServer 10/16/2026 15:19'
}
SRMenuTest >> entryAt: aPath label: aStringOrSymbol priority: anInteger [
	^ SRMenuEntry new
		setPath: aPath
		label: aStringOrSymbol
		priority: anInteger
		provider: self class
		action: #demoAction:target:
]

{
	#category : #helpers,
	#'squeak_changestamp' : 'MCPServer 8/3/2026 14:41'
}
SRMenuTest >> labelsOf: aMenu [
	^ (aMenu children collect: [:each | each label]) asArray
]

{
	#category : #helpers,
	#'squeak_changestamp' : 'MCPServer 8/3/2026 14:41'
}
SRMenuTest >> menuUnder: aPath [
	"A menu inside a container, standing in for the world."

	| menu |
	menu := SRMenu new.
	SRObject new addChild: menu.
	menu addItemsUnder: aPath target: nil.
	menu rebuild.
	^ menu
]

{
	#category : #helpers,
	#'squeak_changestamp' : 'MCPServer (leo) 11/9/2026 14:37'
}
SRMenuTest >> pick: aRow [

	self pick: aRow with: nil.
]

{
	#category : #helpers,
	#'squeak_changestamp' : 'MCPServer (leo) 11/9/2026 14:37'
}
SRMenuTest >> pick: aRow with: aHand [

	aRow handleInput: (SRInputEventButton new
		hand: aHand;
		button: #trigger;
		pressed: true;
		yourself).
]

{
	#category : #helpers,
	#'squeak_changestamp' : 'MCPServer (leo) 11/9/2026 14:37'
}
SRMenuTest >> point: aHand at: aRow [

	aRow handleInput: (SRInputEventCursorEnter new hand: aHand; yourself).
]

{
	#category : #helpers,
	#'squeak_changestamp' : 'MCPServer (leo) 11/9/2026 14:37'
}
SRMenuTest >> point: aHand awayFrom: aRow [

	aRow handleInput: (SRInputEventCursorLeave new hand: aHand; yourself).
]

{
	#category : #helpers,
	#'squeak_changestamp' : 'MCPServer 8/3/2026 14:41'
}
SRMenuTest >> rowOf: aMenu labelled: aString [
	^ aMenu children detect: [:each | each label = aString]
]

{
	#category : #running,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:38'
}
SRMenuTest >> setUp [
	super setUp.
	savedEntries := SRMenuRegistry current registry.
	DemoToggleState := nil.
	SRMenuRegistry current entries: self demoEntries
]

{
	#category : #running,
	#'squeak_changestamp' : 'MCPServer 8/3/2026 14:41'
}
SRMenuTest >> tearDown [
	SRMenuRegistry current entries: savedEntries.
	super tearDown
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (leo) 11/9/2026 14:37'
}
SRMenuTest >> testAHandLeftRestingOnTheParentDoesNotCloseTheSubmenu [

	| menu resting opener sub left right |
	menu := self menuUnder: #(demo).
	resting := self rowOf: menu labelled: 'Alpha'.
	opener := self rowOf: menu labelled: 'Tools >'.
	left := Object new.
	right := Object new.
	self point: left at: resting.
	self point: right at: opener.
	self pick: opener with: right.
	sub := menu submenu.
	self point: right awayFrom: opener.
	self point: right at: (self rowOf: sub labelled: 'Paste').
	self assert: menu submenu == sub.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 15:00'
}
SRMenuTest >> testAMenuIsNotSomethingToStandOn [

	| root menu probe |
	root := SRObject new.
	menu := self menuUnder: #(demo).
	probe := SRObject new.
	root addChild: menu parent.
	root addChild: probe.
	self deny: menu safeCollisionGeometry isNil.
	self assert: 0 equals: (SRSceneSolids forObject: probe) size.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (leo) 11/9/2026 14:37'
}
SRMenuTest >> testASubmenuCoversTheRowThatOpenedIt [
	| menu row sub rowY subTop subBottom |
	menu := self menuUnder: #(demo).
	row := self rowOf: menu labelled: 'Zoo >'.
	self pick: row.
	sub := menu submenu.
	rowY := row globalTranslation y.
	subTop := sub globalTranslation y + (sub slabHeight / 2).
	subBottom := sub globalTranslation y - (sub slabHeight / 2).
	self assert: subTop >= rowY.
	self assert: subBottom <= rowY.
	self assert: subTop <= (menu globalTranslation y + (menu slabHeight / 2) + 1mm).
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (leo) 11/9/2026 14:37'
}
SRMenuTest >> testASubmenuStaysAtAFixedOffsetHoweverDeepTheCascade [
	| menu sub subsub first second |
	menu := self menuUnder: #(demo).
	self pick: (self rowOf: menu labelled: 'Tools >').
	sub := menu submenu.
	sub addSubmenuItemFor: #zoo filledBy: [:m | m addItemsUnder: #(demo zoo) target: nil].
	sub rebuild.
	self pick: (self rowOf: sub labelled: 'Zoo >').
	subsub := sub submenu.
	first := sub globalTranslation - menu globalTranslation.
	second := subsub globalTranslation - sub globalTranslation.
	self assert: (first x closeTo: SRMenu submenuSideOffset).
	self assert: (second x closeTo: SRMenu submenuSideOffset).
	self assert: (first z closeTo: SRMenu submenuForwardOffset).
	self assert: (second z closeTo: SRMenu submenuForwardOffset).
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (leo) 11/9/2026 14:37'
}
SRMenuTest >> testAnActionIgnoringTheHandStillRuns [

	| menu ran |
	ran := false.
	menu := SRMenu new.
	SRObject new addChild: menu.
	menu addItem: 'Go' action: [ran := true].
	menu rebuild.
	self pick: (self rowOf: menu labelled: 'Go').
	self assert: ran.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (leo) 11/9/2026 14:37'
}
SRMenuTest >> testBothHandsCanHighlightAtOnce [

	| menu rows |
	menu := self menuUnder: #(demo).
	rows := menu children select: [:each | each isMenuItem].
	self point: Object new at: rows first.
	self point: Object new at: rows second.
	self assert: rows first hovered.
	self assert: rows second hovered.
	self deny: rows last hovered.
]

{
	#category : #'tests - sticky',
	#'squeak_changestamp' : 'MCPServer (leo) 11/9/2026 14:37'
}
SRMenuTest >> testCloseButtonRemovesTheMenuAndItsSubmenu [
	| menu container sub |
	menu := self menuUnder: #(demo).
	container := menu parent.
	menu sticky: true; rebuild.
	self pick: (self rowOf: menu labelled: 'Tools >').
	sub := menu submenu.
	self pick: (self rowOf: menu labelled: 'X').
	self deny: menu isOpen.
	self deny: sub isOpen.
	self assert: container children isEmpty.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer 8/3/2026 14:50'
}
SRMenuTest >> testDeeperPathsBecomeGroups [
	| labels |
	labels := (SRMenuRegistry current directItemsUnder: #(demo))
		collect: [:each | each label].
	
	self assert: labels asArray = #('Alpha' 'Beta').
	self assert: (SRMenuRegistry current groupsUnder: #(demo)) = #(#tools #zoo)
]

{
	#category : #'tests - sticky',
	#'squeak_changestamp' : 'MCPServer (leo) 11/9/2026 14:37'
}
SRMenuTest >> testGrabbedSubmenuKeepsPickingWithoutClosing [
	| menu sub |
	menu := self menuUnder: #(demo).
	self pick: (self rowOf: menu labelled: 'Tools >').
	sub := menu submenu.
	sub startGrabbing: nil.
	sub rebuild.
	self pick: (self rowOf: sub labelled: 'Paste').
	self assert: sub isOpen.
	self assert: ((self labelsOf: sub) includes: 'X').
]

{
	#category : #'tests - sticky',
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:38'
}
SRMenuTest >> testGrabbingARowGrabsTheMenu [
	| menu row |
	menu := self menuUnder: #(demo).
	row := self rowOf: menu labelled: 'Alpha'.
	self assert: menu == row grabTarget.
]

{
	#category : #'tests - sticky',
	#'squeak_changestamp' : 'MCPServer (leo) 11/9/2026 14:37'
}
SRMenuTest >> testGrabbingASubmenuRemovesItsParents [
	| menu container sub |
	menu := self menuUnder: #(demo).
	container := menu parent.
	self pick: (self rowOf: menu labelled: 'Tools >').
	sub := menu submenu.

	sub startGrabbing: nil.

	self assert: sub isSticky.
	self assert: sub isOpen.
	self deny: menu isOpen.
	self assert: (Array with: sub) equals: container children asArray.
]

{
	#category : #'tests - sticky',
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:38'
}
SRMenuTest >> testGrabbingMakesAMenuSticky [
	| menu |
	menu := self menuUnder: #(demo).
	menu startGrabbing: nil.
	menu rebuild.
	self assert: menu isSticky.
	self assert: ((self labelsOf: menu) includes: 'X').
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer 8/3/2026 14:50'
}
SRMenuTest >> testMenuHasOneRowPerEntryAndGroup [
	self
		assert: (self labelsOf: (self menuUnder: #(demo)))
			= #('Alpha' 'Beta' 'Tools >' 'Zoo >')
]

{
	#category : #'tests - sticky',
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:38'
}
SRMenuTest >> testMenusAreNotStickyByDefault [
	| menu |
	menu := self menuUnder: #(demo).
	self deny: menu isSticky.
	self deny: ((self labelsOf: menu) includes: 'X').
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (leo) 11/9/2026 14:37'
}
SRMenuTest >> testPickingALeafClosesTheWholeCascade [
	| menu container sub |
	menu := self menuUnder: #(demo).
	container := menu parent.
	self pick: (self rowOf: menu labelled: 'Tools >').
	sub := menu submenu.
	self pick: (self rowOf: sub labelled: 'Paste').
	
	self deny: menu isOpen.
	self deny: sub isOpen.
	self assert: container children isEmpty
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (leo) 11/9/2026 14:37'
}
SRMenuTest >> testPickingGroupRowOpensSubmenu [
	| menu |
	menu := self menuUnder: #(demo).
	self pick: (self rowOf: menu labelled: 'Tools >').
	
	self assert: menu submenu parentMenu == menu.
	self assert: menu submenu parent == menu parent.
	self assert: (self labelsOf: menu submenu) = #('Paste' 'Cut')
]

{
	#category : #'tests - sticky',
	#'squeak_changestamp' : 'MCPServer (leo) 11/9/2026 14:37'
}
SRMenuTest >> testPickingInASubmenuLeavesAStickyParentStanding [
	| menu sub |
	menu := self menuUnder: #(demo).
	menu sticky: true; rebuild.
	self pick: (self rowOf: menu labelled: 'Tools >').
	sub := menu submenu.
	self deny: sub isSticky.
	self pick: (self rowOf: sub labelled: 'Paste').
	self deny: sub isOpen.
	self assert: menu isOpen.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (leo) 11/9/2026 14:37'
}
SRMenuTest >> testPointingAwayUnhighlightsARow [

	| row hand |
	row := self rowOf: (self menuUnder: #(demo)) labelled: 'Alpha'.
	hand := Object new.
	self point: hand at: row.
	self point: hand awayFrom: row.
	self deny: row hovered.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (leo) 11/9/2026 14:37'
}
SRMenuTest >> testPointingBackAtAnotherRowOfTheParentClosesTheSubmenu [

	| menu opener sub hand |
	menu := self menuUnder: #(demo).
	opener := self rowOf: menu labelled: 'Tools >'.
	hand := Object new.
	self point: hand at: opener.
	self pick: opener with: hand.
	sub := menu submenu.
	self point: hand awayFrom: opener.
	self point: hand at: (self rowOf: menu labelled: 'Alpha').
	self assert: menu submenu isNil.
	self deny: sub isOpen.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (leo) 11/9/2026 14:37'
}
SRMenuTest >> testRebuildingTheParentKeepsItsSubmenuOpen [

	| menu opener sub hand |
	menu := self menuUnder: #(demo).
	opener := self rowOf: menu labelled: 'Tools >'.
	hand := Object new.
	self point: hand at: opener.
	self pick: opener with: hand.
	sub := menu submenu.
	menu rebuild.
	opener := self rowOf: menu labelled: 'Tools >'.
	self point: hand at: opener.
	self assert: menu submenu == sub.
	self assert: opener hovered.
]

{
	#category : #'tests - sticky',
	#'squeak_changestamp' : 'MCPServer (leo) 11/9/2026 14:37'
}
SRMenuTest >> testStickyMenuRefreshesToggleLabels [
	| menu |
	SRMenuRegistry current entries: self demoEntries , {self toggleEntry}.
	menu := self menuUnder: #(demo).
	menu sticky: true; rebuild.
	self assert: ((self labelsOf: menu) includes: 'toggle: off').
	self pick: (self rowOf: menu labelled: 'toggle: off').
	menu renderOn: SRRecordingRenderer new.
	self assert: ((self labelsOf: menu) includes: 'toggle: on').
]

{
	#category : #'tests - sticky',
	#'squeak_changestamp' : 'MCPServer (leo) 11/9/2026 14:37'
}
SRMenuTest >> testStickyMenuStaysOpenWhenPicking [
	| menu |
	menu := self menuUnder: #(demo).
	menu sticky: true.
	menu rebuild.
	self pick: (self rowOf: menu labelled: 'Alpha').
	self assert: menu isOpen.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (leo) 11/9/2026 14:37'
}
SRMenuTest >> testTheActionReceivesThePickingHand [

	| menu hand seen |
	hand := Object new.
	menu := SRMenu new.
	SRObject new addChild: menu.
	menu addItem: 'Arm' action: [:item :pickingHand | seen := pickingHand].
	menu rebuild.
	self pick: (self rowOf: menu labelled: 'Arm') with: hand.
	self assert: hand == seen.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (leo) 11/9/2026 14:37'
}
SRMenuTest >> testTheSubmenuHidesTheParentRowsBehindIt [
	| menu opener sub hidden ray |
	menu := self menuUnder: #(demo).
	opener := self rowOf: menu labelled: 'Tools >'.
	self pick: opener.
	sub := menu submenu.
	hidden := self rowOf: menu labelled: 'Alpha'.
	ray := SRRay
		origin: hidden globalTranslation + (SRMenu submenuSideOffset @ 0 @ 1)
		forward: 0 @ 0 @ -1.
	self assert: (ray castNearest: menu parent) object == sub.
]

{
	#category : #fixture,
	#'squeak_changestamp' : 'MCPServer 10/16/2026 15:19'
}
SRMenuTest >> toggleEntry [
	"A Symbol label is recomputed from the provider every time it is resolved."

	^ SRMenuEntry new
		setPath: #(demo)
		label: #demoToggleLabel
		priority: 150
		provider: self class
		action: #demoToggle:target:.
]
