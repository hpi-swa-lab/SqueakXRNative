"
SRMenuRegistry finds every class-side method in the image declared with

	<srMenu: #(world apps) label: 'GC Stats' priority: 300>
	<srMenu: #(world apps) label: 'GC Stats'>			""priority defaults to 500""

and answers them filtered by path prefix, so a call site decides which menu it is building:

	SRMenuRegistry current entriesUnder: #(world)			""the XR world menu""
	SRMenuRegistry current entriesUnder: #(gamexr)			""the SWAGame menu""
	SRMenuRegistry current entriesUnder: #(world apps)		""just that group""

A method may carry several <srMenu:...> pragmas and so appear in several menus.

WHY A SCAN AND NOT A COMPILE-TIME HOOK
Pragmas in Squeak are inert metadata in the method's AdditionalMethodState. There is no
install hook and no dispatch at compile time; ClassDescription>>noteCompilationOf:meta:
exists but is per-target-class and effectively abandoned. So this follows the same pattern
as Preferences pragma preferences: prime the cache with one scan, then keep it fresh from
SystemChangeNotifier. A full class-side scan of this image measures about 6 ms.

Crucially the cache is LAZY, not event-authoritative: SystemChangeNotifier>>doSilently:
suppresses all notifications, and both MetacelloPlatform>>suspendSystemUpdateEventsDuring:
and Installer>>installSilently wrap entire package loads in it. Events therefore only
invalidate (entries := nil); the next query rebuilds. A missed event costs one rebuild, not
a missing menu item.
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
	#category : #'SqueakXR-Menus',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 7/30/2026 13:38'
}
SRMenuRegistry class >> current [
	^ Current ifNil: [Current := self new]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 7/30/2026 13:38'
}
SRMenuRegistry class >> flush [
	Current ifNotNil: [:r | r flush]
]

{
	#category : #'class initialization',
	#'squeak_changestamp' : 'MCPServer 7/30/2026 13:38'
}
SRMenuRegistry class >> initialize [
	"Subscribe to system changes. Also flushes, which covers the case where this
	package was loaded inside a doSilently: block and so saw no events at all."
	self current registerForEvents; flush
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 7/30/2026 13:38'
}
SRMenuRegistry class >> pragmaKeywords [
	"The accepted pragma shapes. Pragma keywords are matched whole, so an
	optional argument means a second keyword rather than an optional slot."
	^ #(#srMenu:label: #srMenu:label:priority:)
]

{
	#category : #'class initialization',
	#'squeak_changestamp' : 'MCPServer 7/30/2026 13:38'
}
SRMenuRegistry class >> unload [
	Current ifNotNil: [:r | r unregisterForEvents].
	Current := nil
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'MCPServer 7/30/2026 13:39'
}
SRMenuRegistry >> addItemsUnder: aPrefix to: aMenu context: aContext [
	"Add every registered entry under aPrefix to aMenu. Flat for now: group paths
	become label prefixes rather than submenus. Answer the number of items added.
	A failing entry is skipped rather than taking the whole menu down with it."
	| count |
	count := 0.
	(self entriesUnder: aPrefix) do: [:entry |
		[aMenu
			addItem: (self flatLabelFor: entry under: aPrefix context: aContext)
			action: [entry activateWith: aContext].
		 count := count + 1]
			on: Error
			do: [:e | Transcript cr; show: 'SRMenuRegistry skipped ', entry printString, ': ', e messageText]].
	^ count
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 7/30/2026 13:38'
}
SRMenuRegistry >> entries [
	^ entries ifNil: [entries := self scan]
]

{
	#category : #querying,
	#'squeak_changestamp' : 'MCPServer 7/30/2026 13:38'
}
SRMenuRegistry >> entriesUnder: aPrefix [
	"Every entry whose path starts with aPrefix, in display order: entries are
	clustered by their group (the path relative to aPrefix), groups are ordered by
	the lowest priority they contain, and within a group by priority then label.
	Alphabetical on the group path and on the label breaks remaining ties."
	| prefix matching groups |
	prefix := aPrefix asArray.
	matching := self entries select: [:each | (each isUnder: prefix) and: [each isValid]].
	groups := matching groupBy: [:each | each pathUnder: prefix].
	^ ((groups associations asArray
		sort: [:a :b | | pa pb |
			pa := self lowestPriorityIn: a value.
			pb := self lowestPriorityIn: b value.
			pa = pb
				ifTrue: [(self pathKey: a key) <= (self pathKey: b key)]
				ifFalse: [pa < pb]])
		gather: [:assoc |
			assoc value asArray sort: [:a :b |
				a priority = b priority
					ifTrue: [(self sortLabelFor: a) <= (self sortLabelFor: b)]
					ifFalse: [a priority < b priority]]])
		asArray
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'MCPServer 7/30/2026 13:39'
}
SRMenuRegistry >> flatLabelFor: anEntry under: aPrefix context: aContext [
	"Flat rendering: prefix the label with its group titles. When real submenus
	arrive this method is what goes away, not the declarations."
	| relative label |
	label := anEntry labelFor: aContext.
	relative := anEntry pathUnder: aPrefix asArray.
	relative isEmpty ifTrue: [^ label].
	^ String streamContents: [:s |
		relative do: [:each | s nextPutAll: (self titleFor: each); nextPutAll: ': '].
		s nextPutAll: label]
]

{
	#category : #updating,
	#'squeak_changestamp' : 'MCPServer 7/30/2026 13:38'
}
SRMenuRegistry >> flush [
	"Drop the cache. The next query rebuilds it."
	entries := nil
]

{
	#category : #private,
	#'squeak_changestamp' : 'MCPServer 7/30/2026 13:38'
}
SRMenuRegistry >> lowestPriorityIn: someEntries [
	"A group sorts where its most important member sorts, so no separate API is
	needed to order groups."
	^ someEntries inject: SmallInteger maxVal into: [:min :each | min min: each priority]
]

{
	#category : #updating,
	#'squeak_changestamp' : 'MCPServer 7/30/2026 13:38'
}
SRMenuRegistry >> menuEvent: anEvent [
	"Only invalidate; never try to patch the cache incrementally. See the class
	comment on doSilently:. Class-side method changes and class removals/renames
	are the only things that can affect us."
	anEvent itemKind = SystemChangeNotifier classKind ifTrue: [
		(anEvent isRemoved or: [anEvent isRenamed]) ifTrue: [^ self flush].
		^ self].
	anEvent itemKind = SystemChangeNotifier methodKind ifTrue: [
		anEvent itemClass ifNil: [^ self].
		anEvent itemClass isMeta ifTrue: [^ self flush]]
]

{
	#category : #private,
	#'squeak_changestamp' : 'MCPServer 7/30/2026 13:38'
}
SRMenuRegistry >> pathKey: aPath [
	^ String streamContents: [:s |
		aPath do: [:each | s nextPutAll: each asString] separatedBy: [s nextPut: $/]]
]

{
	#category : #querying,
	#'squeak_changestamp' : 'MCPServer 7/30/2026 13:39'
}
SRMenuRegistry >> paths [
	"Every declared path, sorted. Path roots are free-form symbols, so a typo makes
	an item silently invisible. Look here when an item does not show up."
	^ (self entries collect: [:each | each path]) asSet asArray
		sort: [:a :b | (self pathKey: a) <= (self pathKey: b)]
]

{
	#category : #updating,
	#'squeak_changestamp' : 'MCPServer 7/30/2026 13:38'
}
SRMenuRegistry >> registerForEvents [
	SystemChangeNotifier uniqueInstance
		noMoreNotificationsFor: self;
		notify: self ofAllSystemChangesUsing: #menuEvent:
]

{
	#category : #querying,
	#'squeak_changestamp' : 'MCPServer 7/30/2026 13:39'
}
SRMenuRegistry >> report [
	"Human readable dump of everything registered, grouped by root.
	SRMenuRegistry current report"
	^ String streamContents: [:s |
		s nextPutAll: 'SRMenuRegistry: '; print: self entries size;
		  nextPutAll: ' entries, roots '; print: self roots; cr.
		self roots do: [:root |
			s cr; nextPutAll: root; nextPutAll: ':'; cr.
			(self entriesUnder: {root}) do: [:entry |
				s tab; print: entry; cr]]]
]

{
	#category : #querying,
	#'squeak_changestamp' : 'MCPServer 7/30/2026 13:39'
}
SRMenuRegistry >> roots [
	^ (self entries collect: [:each | each path first]) asSet asArray sort
]

{
	#category : #updating,
	#'squeak_changestamp' : 'MCPServer 7/30/2026 13:38'
}
SRMenuRegistry >> scan [
	"Walk every class-side method in the image looking for our pragmas. About 6 ms.
	Instance-side methods are deliberately not scanned: there is no receiver at scan
	time, and skipping them halves the cost."
	| found keywords |
	found := OrderedCollection new.
	keywords := self class pragmaKeywords.
	Smalltalk allClassesDo: [:aClass |
		aClass class methodsDo: [:method |
			method pragmasDo: [:pragma |
				(keywords includes: pragma keyword) ifTrue: [
					(SRMenuEntry fromPragma: pragma)
						ifNotNil: [:entry | found add: entry]]]]].
	^ found asArray
]

{
	#category : #private,
	#'squeak_changestamp' : 'MCPServer 7/30/2026 13:38'
}
SRMenuRegistry >> sortLabelFor: anEntry [
	"Sort on the static label. A computed (Symbol) label would need a context we do
	not have here, so fall back to the selector for a stable order."
	^ (anEntry labelFor: nil) ifEmpty: [anEntry selector asString]
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'MCPServer 7/30/2026 13:39'
}
SRMenuRegistry >> titleFor: aPathComponent [
	"Display name for a group. The path carries identifiers, not labels; turning
	#apps into 'Apps' is the renderer's business and it can be replaced later
	without touching a single declaration."
	| words |
	words := WriteStream on: String new.
	aPathComponent asString doWithIndex: [:ch :i |
		(i > 1 and: [ch isUppercase]) ifTrue: [words nextPut: $ ].
		words nextPut: (i = 1 ifTrue: [ch asUppercase] ifFalse: [ch])].
	^ words contents
]

{
	#category : #updating,
	#'squeak_changestamp' : 'MCPServer 7/30/2026 13:38'
}
SRMenuRegistry >> unregisterForEvents [
	SystemChangeNotifier uniqueInstance noMoreNotificationsFor: self
]
