"
The registry of XR menu entries. A singleton: SRMenuRegistry current.

Finds every class side method declared with

	<xrMenu: #(world apps) label: 'GC Stats' priority: 300>
	<xrMenu: #(world) label: 'Spawn Cube'>			""priority defaults to 500""

and answers them as SRMenuEntries filtered by path prefix, so a call site picks its menu:

	SRMenuRegistry current itemsUnder: #(world)
	SRMenuRegistry current itemsUnder: #(object)
	SRMenuRegistry current itemsUnder: #(gamexr)

A method may carry several xrMenu pragmas and so appear in several menus.
Scanning is explicit: SRWorld>>start calls ""SRMenuRegistry current updateRegistry"".
Call it again after loading code.
"
Class {
	#name : #SRMenuRegistry,
	#superclass : #Object,
	#instVars : [
		'entries'
	],
	#classVars : [
		'Current'
	],
	#category : #'SqueakXR-Objects',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'MCPServer 8/3/2026 13:03'
}
SRMenuRegistry class >> current [
	^ Current ifNil: [Current := self new]
]

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'MCPServer 8/3/2026 13:03'
}
SRMenuRegistry class >> reset [
	"Throw away the singleton; the next #current builds a fresh one."

	Current := nil
]

{
	#category : #registry,
	#'squeak_changestamp' : 'MCPServer 8/3/2026 13:02'
}
SRMenuRegistry >> buildRegistry [
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
	#'squeak_changestamp' : 'MCPServer 8/3/2026 13:02'
}
SRMenuRegistry >> itemsUnder: aPrefix [
	^ self registry select: [:each | each isUnder: aPrefix]
]

{
	#category : #registry,
	#'squeak_changestamp' : 'MCPServer 8/3/2026 13:02'
}
SRMenuRegistry >> pragmaKeywords [
	^ #(#xrMenu:label: #xrMenu:label:priority:)
]

{
	#category : #registry,
	#'squeak_changestamp' : 'MCPServer 8/3/2026 13:02'
}
SRMenuRegistry >> registry [
	^ entries ifNil: [self updateRegistry]
]

{
	#category : #registry,
	#'squeak_changestamp' : 'MCPServer 8/3/2026 13:02'
}
SRMenuRegistry >> updateRegistry [
	"Rescan the system for xrMenu pragmas. Call after loading code."

	^ entries := self buildRegistry
]
