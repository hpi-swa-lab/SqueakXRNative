Class {
	#name : #SRDockingBarMenuTest,
	#superclass : #TestCase,
	#category : #'SqueakXR-Tests-Objects'
}

{
	#category : #helpers,
	#'squeak_changestamp' : 'jl-MCPServer 11/20/2026 10:45'
}
SRDockingBarMenuTest >> labelsOf: aMenu [
	^ ((aMenu children select: [:each | each isMenuItem]) collect: [:each | each label]) asArray
]

{
	#category : #helpers,
	#'squeak_changestamp' : 'jl-MCPServer 11/20/2026 10:45'
}
SRDockingBarMenuTest >> pick: aRow [
	aRow handleInput: (SRInputEventButton new
		button: #trigger;
		pressed: true;
		yourself).
]

{
	#category : #helpers,
	#'squeak_changestamp' : 'jl-MCPServer 11/20/2026 10:45'
}
SRDockingBarMenuTest >> rowOf: aMenu labelled: aString [
	^ aMenu children detect: [:each | each isMenuItem and: [each label = aString]]
]

{
	#category : #tests,
	#'squeak_changestamp' : 'jl-MCPServer 11/20/2026 10:45'
}
SRDockingBarMenuTest >> testADockingBarSubmenuListsItsMorphicItems [
	| menu squeak |
	menu := self worldMenu.
	self pick: (self rowOf: menu labelled: 'Squeak >').
	squeak := menu submenu.
	self pick: (self rowOf: squeak labelled: 'Tools >').
	self assert: ((self labelsOf: squeak submenu) includesAllOf: #('Browser' 'Workspace' 'Transcript')).
]

{
	#category : #tests,
	#'squeak_changestamp' : 'jl-MCPServer 11/20/2026 10:45'
}
SRDockingBarMenuTest >> testNestedMorphicSubmenusBecomeSubmenus [
	| menu |
	menu := self worldMenu.
	self pick: (self rowOf: menu labelled: 'Squeak >').
	self pick: (self rowOf: menu submenu labelled: 'Extras >').
	self assert: ((self labelsOf: menu submenu submenu) includes: 'Themes & Colors >').
]

{
	#category : #tests,
	#'squeak_changestamp' : 'jl-MCPServer 11/20/2026 10:45'
}
SRDockingBarMenuTest >> testPickingARowInvokesTheMorphicItem [
	| received item menu |
	received := OrderedCollection new.
	item := MenuItemMorph new
		contents: 'Add';
		target: received;
		selector: #add:;
		arguments: #(42);
		yourself.
	menu := SRMenu new.
	SRDockingBarMenu fill: menu from: (MenuMorph new addMenuItem: item; yourself).
	menu rebuild.
	self pick: (self rowOf: menu labelled: 'Add').
	self assert: received asArray = #(42).
]

{
	#category : #tests,
	#'squeak_changestamp' : 'jl-MCPServer 11/20/2026 11:05'
}
SRDockingBarMenuTest >> testSqueakIsTheLastRowOfTheWorldMenu [
	self assert: (self labelsOf: self worldMenu) last = 'Squeak >'.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'jl-MCPServer 11/20/2026 10:45'
}
SRDockingBarMenuTest >> testTheWorldMenuOpensSqueakWithTheDockingBarMenus [
	| menu squeak |
	menu := self worldMenu.
	self pick: (self rowOf: menu labelled: 'Squeak >').
	squeak := menu submenu.
	self assert: squeak parentMenu == menu.
	self assert: (self labelsOf: squeak) = #('Squeak >' 'Projects >' 'Tools >' 'Apps >' 'Do >' 'Extras >' 'Windows >' 'Help >').
]

{
	#category : #helpers,
	#'squeak_changestamp' : 'jl-MCPServer 11/20/2026 10:45'
}
SRDockingBarMenuTest >> worldMenu [
	| menu |
	menu := SRMenu new.
	SRObject new addChild: menu.
	menu addItemsUnder: #(world) target: nil.
	menu rebuild.
	^ menu
]
