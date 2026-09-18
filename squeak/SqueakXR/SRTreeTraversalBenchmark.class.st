"
Recursive against iterative object-tree walking, on a fixed tree of 30 children
with 30 children each.

Two pairs: #allDo: itself, and #allDescendantsSelect:, which is what SRFrame
builds its stepped and rendered lists from twice per frame and is therefore the
one that shows up in a frame budget.
"
Class {
	#name : #SRTreeTraversalBenchmark,
	#superclass : #SRBenchmark,
	#instVars : [
		'root',
		'visited',
		'savedSwitch'
	],
	#category : #'SqueakXR-Benchmarks',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #menu,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 12:01'
}
SRTreeTraversalBenchmark class >> xrMenuRun: aMenu [
	<xrMenu: #(world profile benchmarks) label: 'Tree traversal' priority: 225>
	^ self runFromMenu
]

{
	#category : #menu,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 12:04'
}
SRTreeTraversalBenchmark class >> xrMenuToggleTraversal: aMenu [
	"The same preference the Preference Browser shows under SqueakXR."

	<xrMenu: #(world profile benchmarks) label: #xrMenuTraversalLabel priority: 205>
	SRObject useIterativeTraversal: SRObject useIterativeTraversal not.
]

{
	#category : #menu,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 12:04'
}
SRTreeTraversalBenchmark class >> xrMenuTraversalLabel [
	^ 'tree walk: ' , (SRObject useIterativeTraversal
		ifTrue: ['iterative']
		ifFalse: ['recursive'])
]

{
	#category : #configuring,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 12:01'
}
SRTreeTraversalBenchmark >> branching [
	^ 30.
]

{
	#category : #reporting,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 12:01'
}
SRTreeTraversalBenchmark >> columnNotes [
	^ super columnNotes
		at: self unit put: 'one whole walk of the tree, ms divided by the repeat count';
		at: 'B/node' put: 'bytes allocated per node visited. The recursive walk pays a block closure here';
		yourself.
]

{
	#category : #reporting,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 12:01'
}
SRTreeTraversalBenchmark >> description [
	^ 'Recursive against iterative traversal of a tree of ' , self nodeCount printString ,
' nodes: a root with ' , self branching printString , ' children of ' , self branching printString , ' children each.
Each row repeats its walk ' , self repeats printString , ' times.
recursiveAllDo/withAllObjectsDo are the two implementations behind #allDo:.
recursiveSelect/iterativeSelect run #allDescendantsSelect: through the
SRObject class switch, which is the walk SRFrame does twice per frame, and
which additionally builds an OrderedCollection.'
]

{
	#category : #configuring,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 12:01'
}
SRTreeTraversalBenchmark >> iterationsFor: aParameter [
	^ self repeats.
]

{
	#category : #configuring,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 12:01'
}
SRTreeTraversalBenchmark >> nodeCount [
	^ 1 + self branching + (self branching * self branching).
]

{
	#category : #configuring,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 12:01'
}
SRTreeTraversalBenchmark >> parameterName [
	^ 'traversal'.
]

{
	#category : #configuring,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 12:01'
}
SRTreeTraversalBenchmark >> parameterNote [
	^ 'which walk was repeated; not a size'.
]

{
	#category : #configuring,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 12:01'
}
SRTreeTraversalBenchmark >> parameters [
	^ #(#recursiveAllDo #withAllObjectsDo #recursiveSelect #iterativeSelect).
]

{
	#category : #configuring,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 12:01'
}
SRTreeTraversalBenchmark >> repeats [
	^ 200.
]

{
	#category : #reporting,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 12:01'
}
SRTreeTraversalBenchmark >> reportColumns [
	^ super reportColumns , {
		'B/node' -> [:p | self printNumber: p bytesAllocated / (self repeats * self nodeCount)] }.
]

{
	#category : #running,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 12:01'
}
SRTreeTraversalBenchmark >> runParameter: aParameter [
	aParameter caseOf: {
		[#recursiveAllDo] -> [self repeats timesRepeat: [
			root recursiveAllDo: [:each | visited := visited + 1]]].
		[#withAllObjectsDo] -> [self repeats timesRepeat: [
			root withAllObjectsDo: [:each | visited := visited + 1]]].
		[#recursiveSelect] -> [self repeats timesRepeat: [
			root allDescendantsSelect: #isRendering]].
		[#iterativeSelect] -> [self repeats timesRepeat: [
			root allDescendantsSelect: #isRendering]] }.
	^ nil.
]

{
	#category : #running,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 12:01'
}
SRTreeTraversalBenchmark >> setUpParameter: aParameter [
	"The switch is set here rather than in #runParameter:, so flipping it is not
	part of the measured region."

	savedSwitch := SRObject useIterativeTraversal.
	SRObject useIterativeTraversal: aParameter == #iterativeSelect.
	visited := 0.
	root := SRObject new.
	root addChildren: ((1 to: self branching) collect: [:i |
		SRObject new
			addChildren: ((1 to: self branching) collect: [:j | SRObject new]);
			yourself]).
]

{
	#category : #running,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 12:01'
}
SRTreeTraversalBenchmark >> tearDownParameter: aParameter [
	SRObject useIterativeTraversal: savedSwitch.
	root := nil.
]
