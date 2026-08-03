"
Finds every class side method declared with

	<xrMenu: #(world apps) label: 'GC Stats' priority: 300>
	<xrMenu: #(world) label: 'Spawn Cube'>			""priority defaults to 500""

and answers them as SRMenuEntries filtered by path prefix, so a call site picks its menu:

	SRMenuRegistry itemsUnder: #(world)
	SRMenuRegistry itemsUnder: #(object)
	SRMenuRegistry itemsUnder: #(gamexr)

A method may carry several xrMenu pragmas and so appear in several menus.
Scanning is explicit: SRWorld>>start calls updateRegistry. Call it again after loading code.
"
Class {
	#name : #SRMenuRegistry,
	#superclass : #Object,
	#classVars : [
		'Registry'
	],
	#category : #'SqueakXR-Objects',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #registry,
	#'squeak_changestamp' : 'MCPServer 7/30/2026 17:36'
}
SRMenuRegistry class >> buildRegistry [
	| found |
	found := OrderedCollection new.
	Smalltalk allClassesDo: [:aClass |
		aClass class methodsDo: [:method |
			method pragmasDo: [:p |
				(self pragmaKeywords includes: p keyword) ifTrue: [
					found add: (SRMenuEntry fromPragma: p)]]]].
	^ found asArray sort: [:a :b |
		a pathString = b pathString
			ifTrue: [a priority = b priority
				ifTrue: [a selector <= b selector]
				ifFalse: [a priority < b priority]]
			ifFalse: [a pathString <= b pathString]]
]

{
	#category : #registry,
	#'squeak_changestamp' : 'MCPServer 7/30/2026 17:36'
}
SRMenuRegistry class >> itemsUnder: aPrefix [
	^ self registry select: [:each | each isUnder: aPrefix]
]

{
	#category : #registry,
	#'squeak_changestamp' : 'MCPServer 7/30/2026 17:36'
}
SRMenuRegistry class >> pragmaKeywords [
	^ #(#xrMenu:label: #xrMenu:label:priority:)
]

{
	#category : #registry,
	#'squeak_changestamp' : 'MCPServer 7/30/2026 17:36'
}
SRMenuRegistry class >> registry [
	^ Registry ifNil: [self updateRegistry]
]

{
	#category : #registry,
	#'squeak_changestamp' : 'MCPServer 7/30/2026 17:36'
}
SRMenuRegistry class >> updateRegistry [
	^ Registry := self buildRegistry
]
