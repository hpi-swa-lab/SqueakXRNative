"
Puts the menus of the Squeak docking bar (TheWorldMainDockingBar) in the XR world menu under ""Squeak"", so the XR world offers what the desktop world does without copying each item.

The Morphic menus are built afresh each time a submenu opens, which keeps dynamic ones like Windows and Apps current.
"
Class {
	#name : #SRDockingBarMenu,
	#superclass : #Object,
	#category : #'SqueakXR-Objects',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #building,
	#'squeak_changestamp' : 'jl-MCPServer 11/20/2026 11:05'
}
SRDockingBarMenu class >> dockingBarItems [
	| bar |
	bar := DockingBarMorph new.
	TheWorldMainDockingBar instance menusOn: bar.
	^ bar submorphs select: [:each | each subMenu notNil]
]

{
	#category : #building,
	#'squeak_changestamp' : 'jl-MCPServer 11/20/2026 10:44'
}
SRDockingBarMenu class >> fill: anSRMenu from: aMenuMorph [
	(aMenuMorph respondsTo: #updateMenu) ifTrue: [aMenuMorph updateMenu].
	aMenuMorph items do: [:each |
		each subMenu
			ifNil: [anSRMenu addItem: each contents asString action: [self invoke: each]]
			ifNotNil: [:morphicSubmenu |
				anSRMenu
					addSubmenuItemFor: each contents asString
					filledBy: [:sub | self fill: sub from: morphicSubmenu]]]
]

{
	#category : #building,
	#'squeak_changestamp' : 'jl-MCPServer 11/20/2026 11:05'
}
SRDockingBarMenu class >> fill: anSRMenu fromDockingBarItemLabelled: aString [
	"A fresh docking bar each time, so dynamic menus like Windows are current."
	self dockingBarItems
		detect: [:each | (self labelOfDockingBarItem: each) = aString]
		ifFound: [:each | self fill: anSRMenu from: each subMenu].
]

{
	#category : #actions,
	#'squeak_changestamp' : 'jl-MCPServer 11/20/2026 10:44'
}
SRDockingBarMenu class >> invoke: aMenuItemMorph [
	"The Morphic menu is in no world, so invoking it neither pops anything down nor needs an event."
	^ aMenuItemMorph invokeWithEvent: nil
]

{
	#category : #building,
	#'squeak_changestamp' : 'jl-MCPServer 11/20/2026 10:44'
}
SRDockingBarMenu class >> labelOfDockingBarItem: aDockingBarItemMorph [
	"The first item shows only the Squeak logo."
	^ aDockingBarItemMorph contents asString
		ifEmpty: ['Squeak']
]

{
	#category : #'menu entries',
	#'squeak_changestamp' : 'jl-MCPServer 11/20/2026 11:05'
}
SRDockingBarMenu class >> menuEntries [
	<xrMenuEntries>
	"The priority puts the Squeak group after every other group of the world menu."
	^ (self dockingBarItems collect: [:each | self labelOfDockingBarItem: each])
		withIndexCollect: [:label :index |
			SRMenuEntry new
				setPath: #(world Squeak)
				label: (SRMenu submenuLabelFor: label)
				priority: 1000000 + index
				provider: self
				action: [:menu :target :item | menu
					openSubmenuFromItem: item
					filledBy: [:sub | self fill: sub fromDockingBarItemLabelled: label]];
				keepOpen: true;
				yourself]
]
