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
	#'squeak_changestamp' : 'MCPServer 8/3/2026 15:55'
}
SRMenuRegistry class >> reset [
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
	#'squeak_changestamp' : 'MCPServer 8/10/2026 13:54'
}
SRMenuRegistry >> directItemsUnder: aPrefix [
	| prefix |
	prefix := aPrefix asArray.
	^ self registry select: [:each | each path = prefix]
]

{
	#category : #private,
	#'squeak_changestamp' : 'MCPServer 8/3/2026 14:41'
}
SRMenuRegistry >> entries: aCollection [
	entries := aCollection
]

{
	#category : #registry,
	#'squeak_changestamp' : 'MCPServer 8/3/2026 14:37'
}
SRMenuRegistry >> groupsUnder: aPrefix [
	"Ordered by the lowest priority in the group, then alphabetically."

	| prefix priorities |
	prefix := aPrefix asArray.
	priorities := Dictionary new.
	self registry do: [:each | | key |
		((each isUnder: prefix) and: [each path size > prefix size]) ifTrue: [
			key := each path at: prefix size + 1.
			priorities at: key put: ((priorities at: key ifAbsent: [each priority]) min: each priority)]].
	^ (priorities associations asArray sort: [:a :b |
		a value = b value
			ifTrue: [a key <= b key]
			ifFalse: [a value < b value]])
				collect: [:assoc | assoc key]
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
	#'squeak_changestamp' : 'MCPServer 8/3/2026 15:55'
}
SRMenuRegistry >> updateRegistry [
	"Call after loading code."

	^ entries := self buildRegistry
]
