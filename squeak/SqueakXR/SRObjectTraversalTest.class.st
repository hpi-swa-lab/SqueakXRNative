"
Covers #withAllObjectsDo: against #recursiveAllDo: and the SRObject class
switch that selects between them. The switch is global, so it is saved and
restored per test.
"
Class {
	#name : #SRObjectTraversalTest,
	#superclass : #TestCase,
	#instVars : [
		'savedSwitch'
	],
	#category : #'SqueakXR-Tests-Objects',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #fixture,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 10:42'
}
SRObjectTraversalTest >> bytesAllocatedDuring: aBlock [
	| before |
	before := Smalltalk vmParameterAt: 34.
	aBlock value.
	^ (Smalltalk vmParameterAt: 34) - before.
]

{
	#category : #fixture,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 10:42'
}
SRObjectTraversalTest >> namesVisitedBy: aBlock [
	| names |
	names := OrderedCollection new.
	aBlock value: [:each | names add: each name].
	^ names asArray.
]

{
	#category : #running,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 10:42'
}
SRObjectTraversalTest >> setUp [
	super setUp.
	savedSwitch := SRObject useIterativeTraversal.
]

{
	#category : #running,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 10:42'
}
SRObjectTraversalTest >> tearDown [
	SRObject useIterativeTraversal: savedSwitch.
	super tearDown.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 10:42'
}
SRObjectTraversalTest >> testAcceptsNiladicBlock [
	"#allDo: culls, so callers may pass a block taking no argument."

	| root count |
	root := self treeOfDepth: 3 branching: 2.
	count := 0.
	root withAllObjectsDo: [count := count + 1].
	self assert: 7 equals: count.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 12:02'
}
SRObjectTraversalTest >> testBenchmarkComparesBothImplementations [
	| benchmark at |
	benchmark := SRTreeTraversalBenchmark new run.
	self assert: 931 equals: benchmark nodeCount.
	at := [:name | (benchmark points detect: [:p | p parameter == name]) bytesAllocated].
	self assert: (at value: #withAllObjectsDo) * 10 < (at value: #recursiveAllDo).
	self assert: (at value: #iterativeSelect) < (at value: #recursiveSelect).
	self assert: savedSwitch equals: SRObject useIterativeTraversal.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 10:46'
}
SRObjectTraversalTest >> testDeepChainDoesNotRecurse [
	| root node count |
	root := SRObject new.
	node := root.
	2000 timesRepeat: [| child |
		child := SRObject new.
		node addChild: child.
		node := child].
	count := 0.
	root withAllObjectsDo: [:each | count := count + 1].
	self assert: 2001 equals: count.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 10:42'
}
SRObjectTraversalTest >> testGrowsBeyondInitialStack [
	"More children than the 64 slots the stack starts with."

	| root count |
	root := SRObject new.
	root addChildren: ((1 to: 500) collect: [:i | SRObject new]).
	count := 0.
	root withAllObjectsDo: [:each | count := count + 1].
	self assert: 501 equals: count.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 10:42'
}
SRObjectTraversalTest >> testIterativeAllocatesLessPerNode [
	"The whole point of the iterative walk: no closure per node."

	| root count recursive iterative |
	root := SRObject new.
	root addChildren: ((1 to: 2000) collect: [:i | SRObject new]).
	count := 0.
	recursive := self bytesAllocatedDuring: [root recursiveAllDo: [:each | count := count + 1]].
	iterative := self bytesAllocatedDuring: [root withAllObjectsDo: [:each | count := count + 1]].
	self assert: iterative * 4 < recursive.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 12:05'
}
SRObjectTraversalTest >> testMenuTogglesTheSwitch [
	SRObject useIterativeTraversal: false.
	self assert: 'tree walk: recursive' equals: SRTreeTraversalBenchmark xrMenuTraversalLabel.
	SRTreeTraversalBenchmark xrMenuToggleTraversal: nil.
	self assert: SRObject useIterativeTraversal.
	SRTreeTraversalBenchmark xrMenuToggleTraversal: nil.
	self deny: SRObject useIterativeTraversal.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 10:42'
}
SRObjectTraversalTest >> testPreOrder [
	| root |
	root := self treeOfDepth: 3 branching: 2.
	self
		assert: #('n' 'n1' 'n11' 'n12' 'n2' 'n21' 'n22')
		equals: (self namesVisitedBy: [:block | root withAllObjectsDo: block]).
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 10:42'
}
SRObjectTraversalTest >> testSameOrderAsRecursive [
	| root |
	root := self treeOfDepth: 4 branching: 3.
	self
		assert: (self namesVisitedBy: [:block | root recursiveAllDo: block])
		equals: (self namesVisitedBy: [:block | root withAllObjectsDo: block]).
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 12:05'
}
SRObjectTraversalTest >> testSwitchIsAPreference [
	| preference |
	preference := (Preferences preferencesInCategory: #SqueakXR)
		detect: [:each | each name = 'Iterative object tree traversal'].
	SRObject useIterativeTraversal: false.
	preference preferenceValue: true.
	self assert: SRObject useIterativeTraversal.
	self assert: 'tree walk: iterative' equals: SRTreeTraversalBenchmark xrMenuTraversalLabel.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 10:42'
}
SRObjectTraversalTest >> testSwitchSelectsImplementation [
	| root recursive iterative |
	root := self treeOfDepth: 4 branching: 3.
	SRObject useIterativeTraversal: false.
	recursive := self namesVisitedBy: [:block | root allDo: block].
	SRObject useIterativeTraversal: true.
	iterative := self namesVisitedBy: [:block | root allDo: block].
	self assert: recursive equals: iterative.
	self assert: 40 equals: recursive size.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 10:42'
}
SRObjectTraversalTest >> testVisitsEveryNode [
	| root visited |
	root := self treeOfDepth: 5 branching: 3.
	visited := IdentitySet new.
	root withAllObjectsDo: [:each | visited add: each].
	self assert: 121 equals: visited size.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 10:42'
}
SRObjectTraversalTest >> testVisitsRootAlone [
	| root visited |
	root := SRObject new.
	visited := OrderedCollection new.
	root withAllObjectsDo: [:each | visited add: each].
	self assert: (Array with: root) equals: visited asArray.
]

{
	#category : #fixture,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 10:43'
}
SRObjectTraversalTest >> treeNamed: aString depth: depth branching: branching [
	| root |
	root := SRObject new name: aString; yourself.
	depth > 1 ifTrue: [
		root addChildren: ((1 to: branching) collect: [:i |
			self treeNamed: aString , i printString depth: depth - 1 branching: branching])].
	^ root.
]

{
	#category : #fixture,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 10:43'
}
SRObjectTraversalTest >> treeOfDepth: depth branching: branching [
	^ self treeNamed: 'n' depth: depth branching: branching.
]
