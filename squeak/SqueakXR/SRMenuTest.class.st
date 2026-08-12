"
Tests for SRMenu, its submenu cascade and the SRMenuRegistry grouping. The registry singleton is loaded with a known set of entries under #(demo) for the duration of each test.
"
Class {
	#name : #SRMenuTest,
	#superclass : #TestCase,
	#instVars : [
		'savedEntries'
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
	#'squeak_changestamp' : 'MCPServer 8/3/2026 14:50'
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
	#'squeak_changestamp' : 'MCPServer 8/3/2026 14:41'
}
SRMenuTest >> setUp [
	super setUp.
	savedEntries := SRMenuRegistry current registry.
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
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer 8/3/2026 14:50'
}
SRMenuTest >> testMenuHasOneRowPerEntryAndGroup [
	self
		assert: (self labelsOf: (self menuUnder: #(demo)))
			= #('Alpha' 'Beta' 'Tools >' 'Zoo >')
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
