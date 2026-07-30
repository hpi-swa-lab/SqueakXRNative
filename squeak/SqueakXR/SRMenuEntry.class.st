"
SRMenuEntry is one item discovered by SRMenuRegistry: a single class-side method declared with

	<srMenu: #(world apps) label: 'GC Stats' priority: 300>

	path		Array of Symbols. The LAST component is not the label; the whole path is
			the container the item wants to live in. #(world apps) means ""in the world
			menu, in the apps group"". Call sites ask for a prefix, so #(world) finds it.
	label		A String, or a Symbol naming a unary/niladic method on the provider that
			computes the label at build time (for toggles like 'Debug HUD: ON').
	priority	Lower sorts earlier. Defaults to 500, matching Squeak's <menuPriority:>.
	provider	The class holding the method. Methods are always CLASS side.
	selector	The method to perform. It is both the declaration and the action.

Both label resolution and activation use #withEnoughArguments:, so the method may accept
an SRMenuContext or accept nothing.
"
Class {
	#name : #SRMenuEntry,
	#superclass : #Object,
	#instVars : [
		'path',
		'label',
		'priority',
		'provider',
		'selector'
	],
	#category : #'SqueakXR-Menus',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'MCPServer 7/30/2026 13:37'
}
SRMenuEntry class >> fromPragma: aPragma [
	"Answer an entry for a <srMenu:label:> or <srMenu:label:priority:> pragma,
	or nil if the pragma is malformed. aPragma method is always class side, so
	the provider is the non-meta class and we perform on it directly."
	| args |
	args := aPragma arguments.
	args size < 2 ifTrue: [^ nil].
	(args first isCollection and: [args first isString not]) ifFalse: [^ nil].
	^ self new
		setPath: (args first collect: [:each | each asSymbol]) asArray
		label: args second
		priority: (args size >= 3 ifTrue: [args third] ifFalse: [500])
		provider: aPragma methodClass theNonMetaClass
		selector: aPragma selector
]

{
	#category : #building,
	#'squeak_changestamp' : 'MCPServer 7/30/2026 13:37'
}
SRMenuEntry >> activateWith: aContext [
	"The declaring method is the action. It may take the context or nothing."
	^ provider perform: selector withEnoughArguments: {aContext}
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 7/30/2026 13:37'
}
SRMenuEntry >> id [
	"Identity of the declaration site, so a recompile replaces rather than duplicates.
	Same trick as PragmaPreference>>id."
	^ (provider name, '>>', selector) asSymbol
]

{
	#category : #testing,
	#'squeak_changestamp' : 'MCPServer 7/30/2026 13:37'
}
SRMenuEntry >> isUnder: aPrefix [
	"True if my path starts with aPrefix. An empty prefix matches everything."
	aPrefix size > path size ifTrue: [^ false].
	^ (path first: aPrefix size) = aPrefix asArray
]

{
	#category : #testing,
	#'squeak_changestamp' : 'MCPServer 7/30/2026 13:38'
}
SRMenuEntry >> isValid [
	"The declaring method may have been removed since the scan."
	^ (provider class includesSelector: selector)
		and: [path notEmpty]
]

{
	#category : #building,
	#'squeak_changestamp' : 'MCPServer 7/30/2026 13:37'
}
SRMenuEntry >> labelFor: aContext [
	"A String label is used as is. A Symbol label names a method on the provider
	that computes it, so toggles can say 'Debug HUD: ON'."
	label isSymbol ifFalse: [^ label asString].
	^ [(provider perform: label withEnoughArguments: {aContext}) asString]
		on: Error
		do: [:e | label asString]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 7/30/2026 13:37'
}
SRMenuEntry >> path [
	^ path
]

{
	#category : #building,
	#'squeak_changestamp' : 'MCPServer 7/30/2026 13:38'
}
SRMenuEntry >> pathUnder: aPrefix [
	"My path relative to aPrefix: the groups I want to be nested in below the
	menu that is being built. Empty means 'a top level item of that menu'.
	A flat renderer ignores this; a nested one turns it into submenus."
	^ path allButFirst: aPrefix size
]

{
	#category : #printing,
	#'squeak_changestamp' : 'MCPServer 7/30/2026 13:38'
}
SRMenuEntry >> printOn: aStream [
	aStream nextPut: $(.
	path do: [:each | aStream nextPutAll: each] separatedBy: [aStream nextPut: $/].
	aStream
		nextPutAll: ') ';
		print: label;
		nextPutAll: ' p'; print: priority;
		nextPutAll: ' <- '; nextPutAll: provider name;
		nextPutAll: ' class>>'; nextPutAll: selector
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 7/30/2026 13:37'
}
SRMenuEntry >> priority [
	^ priority
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 7/30/2026 13:37'
}
SRMenuEntry >> provider [
	^ provider
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 7/30/2026 13:37'
}
SRMenuEntry >> selector [
	^ selector
]

{
	#category : #private,
	#'squeak_changestamp' : 'MCPServer 7/30/2026 13:37'
}
SRMenuEntry >> setPath: anArray label: aStringOrSymbol priority: anInteger provider: aClass selector: aSelector [
	path := anArray.
	label := aStringOrSymbol.
	priority := anInteger.
	provider := aClass.
	selector := aSelector
]
