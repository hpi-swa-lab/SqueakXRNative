"
One menu declaration found by SRMenuRegistry:

	<xrMenu: #(world apps) label: 'GC Stats' priority: 300>

path is the container, not the label. label is a String, or a Symbol naming a method on
provider that computes it. provider is the class holding the method, always class side,
and selector is both the declaration and the action.

Not to be confused with SRMenuItem, which is the rendered row in the world.
"
Class {
	#name : #SRMenuEntry,
	#superclass : #Object,
	#instVars : [
		'path',
		'label',
		'priority',
		'provider',
		'action',
		'keepOpen'
	],
	#category : #'SqueakXR-Objects',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'MCPServer 10/16/2026 15:13'
}
SRMenuEntry class >> fromPragma: aPragma [
	^ self new
		setPath: (aPragma argumentAt: 1) asArray
		label: (aPragma argumentAt: 2)
		priority: (aPragma arguments size >= 3 ifTrue: [aPragma argumentAt: 3] ifFalse: [500])
		provider: aPragma methodClass theNonMetaClass
		action: aPragma selector
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 10/16/2026 15:14'
}
SRMenuEntry >> action [
	^ action
]

{
	#category : #building,
	#'squeak_changestamp' : 'MCPServer 10/16/2026 15:13'
}
SRMenuEntry >> activateIn: aMenu target: anObjectOrNil [
	action isSymbol ifFalse: [^ action value].
	^ provider perform: action withEnoughArguments: {aMenu. anObjectOrNil}
]

{
	#category : #querying,
	#'squeak_changestamp' : 'MCPServer 7/30/2026 17:36'
}
SRMenuEntry >> isUnder: aPrefix [
	^ aPrefix size <= path size
		and: [(path first: aPrefix size) = aPrefix asArray]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 10/16/2026 15:14'
}
SRMenuEntry >> keepOpen [
	^ keepOpen ifNil: [false]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 10/16/2026 15:14'
}
SRMenuEntry >> keepOpen: aBoolean [
	keepOpen := aBoolean
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 7/30/2026 17:36'
}
SRMenuEntry >> label [
	^ label
]

{
	#category : #building,
	#'squeak_changestamp' : 'MCPServer 10/16/2026 15:13'
}
SRMenuEntry >> labelIn: aMenu target: anObjectOrNil [
	"A Symbol label is computed by the provider, for toggles."
	label isSymbol ifTrue: [
		^ (provider perform: label withEnoughArguments: {aMenu. anObjectOrNil}) asString].
	label isString ifTrue: [^ label].
	^ label value asString
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 7/30/2026 17:36'
}
SRMenuEntry >> path [
	^ path
]

{
	#category : #querying,
	#'squeak_changestamp' : 'MCPServer 7/30/2026 17:36'
}
SRMenuEntry >> pathString [
	^ String streamContents: [:s |
		path do: [:each | s nextPutAll: each asString] separatedBy: [s nextPut: $/]]
]

{
	#category : #querying,
	#'squeak_changestamp' : 'MCPServer 7/30/2026 17:36'
}
SRMenuEntry >> pathUnder: aPrefix [
	^ path allButFirst: aPrefix size
]

{
	#category : #printing,
	#'squeak_changestamp' : 'MCPServer 10/16/2026 15:13'
}
SRMenuEntry >> printOn: aStream [
	aStream
		nextPut: $(; nextPutAll: self pathString; nextPutAll: ') ';
		print: label;
		nextPutAll: ' p'; print: priority;
		nextPutAll: ' <- '; nextPutAll: provider name;
		nextPutAll: ' class>>'; print: action
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 7/30/2026 17:36'
}
SRMenuEntry >> priority [
	^ priority
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 7/30/2026 17:36'
}
SRMenuEntry >> provider [
	^ provider
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 15:00'
}
SRMenuEntry >> setPath: anArray label: aStringSymbolOrBlock priority: anInteger provider: aClass action: aSelectorOrBlock [

	path := anArray.
	label := aStringSymbolOrBlock.
	priority := anInteger.
	provider := aClass.
	action := aSelectorOrBlock.
	keepOpen := false.
]
