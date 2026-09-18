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
	#'squeak_changestamp' : 'MCPServer 8/3/2026 14:41'
}
SRMenuTest >> entryAt: aPath label: aStringOrSymbol priority: anInteger [
	^ SRMenuEntry new
		setPath: aPath
		label: aStringOrSymbol
		priority: anInteger
		provider: self class
		selector: #demoAction:target:
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
	#category : #'tests - sticky',
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:45'
}
SRMenuTest >> testCloseButtonRemovesTheMenuAndItsSubmenu [
	| menu container sub |
	menu := self menuUnder: #(demo).
	container := menu parent.
	menu sticky: true; rebuild.
	(self rowOf: menu labelled: 'Tools >') onRaycast: nil.
	sub := menu submenu.
	(self rowOf: menu labelled: 'X') onRaycast: nil.
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
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:45'
}
SRMenuTest >> testGrabbedSubmenuKeepsPickingWithoutClosing [
	| menu sub |
	menu := self menuUnder: #(demo).
	(self rowOf: menu labelled: 'Tools >') onRaycast: nil.
	sub := menu submenu.
	sub startGrabbing: nil.
	sub rebuild.
	(self rowOf: sub labelled: 'Paste') onRaycast: nil.
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
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:45'
}
SRMenuTest >> testGrabbingASubmenuRemovesItsParents [
	| menu container sub |
	menu := self menuUnder: #(demo).
	container := menu parent.
	(self rowOf: menu labelled: 'Tools >') onRaycast: nil.
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
	#'squeak_changestamp' : 'MCPServer 8/3/2026 14:41'
}
SRMenuTest >> testPickingALeafClosesTheWholeCascade [
	| menu container sub |
	menu := self menuUnder: #(demo).
	container := menu parent.
	(self rowOf: menu labelled: 'Tools >') onRaycast: nil.
	sub := menu submenu.
	(self rowOf: sub labelled: 'Paste') onRaycast: nil.
	
	self deny: menu isOpen.
	self deny: sub isOpen.
	self assert: container children isEmpty
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer 8/3/2026 14:50'
}
SRMenuTest >> testPickingGroupRowOpensSubmenu [
	| menu |
	menu := self menuUnder: #(demo).
	(self rowOf: menu labelled: 'Tools >') onRaycast: nil.
	
	self assert: menu submenu parentMenu == menu.
	self assert: menu submenu parent == menu parent.
	self assert: (self labelsOf: menu submenu) = #('Paste' 'Cut')
]

{
	#category : #'tests - sticky',
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:45'
}
SRMenuTest >> testPickingInASubmenuLeavesAStickyParentStanding [
	| menu sub |
	menu := self menuUnder: #(demo).
	menu sticky: true; rebuild.
	(self rowOf: menu labelled: 'Tools >') onRaycast: nil.
	sub := menu submenu.
	self deny: sub isSticky.
	(self rowOf: sub labelled: 'Paste') onRaycast: nil.
	self deny: sub isOpen.
	self assert: menu isOpen.
]

{
	#category : #'tests - sticky',
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:39'
}
SRMenuTest >> testStickyMenuRefreshesToggleLabels [
	| menu |
	SRMenuRegistry current entries: self demoEntries , {self toggleEntry}.
	menu := self menuUnder: #(demo).
	menu sticky: true; rebuild.
	self assert: ((self labelsOf: menu) includes: 'toggle: off').
	(self rowOf: menu labelled: 'toggle: off') onRaycast: nil.
	menu renderOn: SRRecordingRenderer new.
	self assert: ((self labelsOf: menu) includes: 'toggle: on').
]

{
	#category : #'tests - sticky',
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:38'
}
SRMenuTest >> testStickyMenuStaysOpenWhenPicking [
	| menu |
	menu := self menuUnder: #(demo).
	menu sticky: true.
	menu rebuild.
	(self rowOf: menu labelled: 'Alpha') onRaycast: nil.
	self assert: menu isOpen.
]

{
	#category : #fixture,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:38'
}
SRMenuTest >> toggleEntry [
	"A Symbol label is recomputed from the provider every time it is resolved."

	^ SRMenuEntry new
		setPath: #(demo)
		label: #demoToggleLabel
		priority: 150
		provider: self class
		selector: #demoToggle:target:.
]
