"
Abstract parameterised benchmark. A subclass answers a list of #parameters and
implements #runParameter:, and running it yields a curve rather than a single
number.

Every point brackets the measured region with VM counter reads (old space,
scavenge and full GC counts, tenures, remembered-table size, bytes allocated),
because a timing without them cannot distinguish work from collection -- the
7 ms Quest scavenge is invisible in wall time alone.

Subclass responsibilities:
	parameters		the x axis, e.g. #(100 1000 10000)
	runParameter:	do the work; answer nil to report elapsed micros per
					iteration, or a number to report that instead
	unit			what #value means, default 'us'

World-dependent subclasses answer true to #needsWorld and are handed the already
running SRWorld. They must never create one, and #tearDownParameter: must leave
it as it was found.
"
Class {
	#name : #SRBenchmark,
	#superclass : #Object,
	#instVars : [
		'points'
	],
	#classVars : [
		'StopButton',
		'StopRequested'
	],
	#category : #'SqueakXR-Benchmarks',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #running,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 17:12'
}
SRBenchmark class >> allBenchmarks [
	^ (self withAllSubclasses reject: [:each | each isAbstract])
		asSortedCollection: [:a :b | a name <= b name]
]

{
	#category : #stopping,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 18:17'
}
SRBenchmark class >> clearStop [
	StopRequested := false.
]

{
	#category : #measuring,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 17:12'
}
SRBenchmark class >> counterIndices [
	"vmParameterAt: indices captured around every measured region. Positional and
	undocumented in the VM, so they are named here rather than at the call sites."
	^ #(1 7 9 10 11 21 34)
]

{
	#category : #measuring,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 17:12'
}
SRBenchmark class >> counterNames [
	^ Dictionary newFrom: {
		1 -> 'oldSpaceBytes'.
		7 -> 'fullGCs'.
		9 -> 'scavenges'.
		10 -> 'gcMillis'.
		11 -> 'tenures'.
		21 -> 'rootTable'.
		34 -> 'bytesAllocated' }
]

{
	#category : #menu,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 17:40'
}
SRBenchmark class >> fixedWidth: aString [
	"The report is a markdown table, so its columns only line up in a fixed font."
	| text |
	text := aString asText.
	text addAttribute: (TextFontReference toFont: TextStyle defaultFixed defaultFont).
	^ text
]

{
	#category : #stopping,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 18:29'
}
SRBenchmark class >> forgetStopButton [
	"Drops the reference without removing anything: for a sign that is taking itself
	down, so the run's #hideStopButton does not try again."
	StopButton := nil.
]

{
	#category : #stopping,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 18:18'
}
SRBenchmark class >> hideStopButton [
	| world button |
	StopButton ifNil: [^ self].
	button := StopButton.
	StopButton := nil.
	world := SRWorld current.
	world ifNotNil: [world addDeferredFrameMessage: [world removeChild: button]].
]

{
	#category : #testing,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 17:12'
}
SRBenchmark class >> isAbstract [
	^ self == SRBenchmark
]

{
	#category : #reporting,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 17:41'
}
SRBenchmark class >> isNumeric: aString [
	^ aString notEmpty
		and: [aString allSatisfy: [:c | c isDigit or: [c = $. or: [c = $-]]]]
]

{
	#category : #stopping,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 18:17'
}
SRBenchmark class >> isStopRequested [
	^ StopRequested == true
]

{
	#category : #menu,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 18:44'
}
SRBenchmark class >> openWorkspaceOn: aBenchmark [
	| text |
	text := String streamContents: [:s |
		s nextPutAll: aBenchmark report; cr.
		s nextPutAll: aBenchmark class name; nextPutAll: ' runFromMenu'; cr.
		s nextPutAll: aBenchmark class name; nextPutAll: ' run asJsonString'; cr].
	^ ((Workspace new contents: (self fixedWidth: text)) openLabel: aBenchmark title)
		extent: 2250 @ 1200
]

{
	#category : #reporting,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 17:55'
}
SRBenchmark class >> renderTable: rows [
	"Markdown, but padded to the column widths so it also reads as a table in a fixed
	font. A column is right-aligned when every body cell in it is a number, which is
	what makes a curve scannable downwards, and the choice is carried in the
	separator row where markdown expects it."
	| count widths rightAligned line |
	count := rows first size.
	widths := (1 to: count) collect: [:i |
		3 max: (rows inject: 0 into: [:max :row | max max: (row at: i) size])].
	rightAligned := (1 to: count) collect: [:i |
		rows allButFirst allSatisfy: [:row | self isNumeric: (row at: i)]].
	line := [:row | String streamContents: [:s |
		s nextPut: $|.
		row withIndexDo: [:cell :i |
			s nextPut: $ ;
				nextPutAll: (cell padded: ((rightAligned at: i) ifTrue: [#left] ifFalse: [#right])
								to: (widths at: i)
								with: $ );
				nextPutAll: ' |']]].
	^ String streamContents: [:s |
		s nextPutAll: (line value: rows first); cr.
		s nextPut: $|.
		1 to: count do: [:i |
			s nextPut: ((rightAligned at: i) ifTrue: [$-] ifFalse: [$:]).
			s next: (widths at: i) put: $-.
			s nextPut: ((rightAligned at: i) ifTrue: [$:] ifFalse: [$-]).
			s nextPut: $|].
		s cr.
		rows allButFirst do: [:row | s nextPutAll: (line value: row); cr]]
]

{
	#category : #reporting,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 17:12'
}
SRBenchmark class >> reportAll [
	^ String streamContents: [:s |
		self runAll do: [:each | s nextPutAll: each report; cr]]
]

{
	#category : #stopping,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 18:17'
}
SRBenchmark class >> requestStop [
	StopRequested := true.
]

{
	#category : #running,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 17:12'
}
SRBenchmark class >> run [
	^ self new run
]

{
	#category : #running,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 17:12'
}
SRBenchmark class >> runAll [
	^ self allBenchmarks collect: [:each | each run]
]

{
	#category : #menu,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 18:41'
}
SRBenchmark class >> runFromMenu [
	"A benchmark that needs frames is stepped one state per frame and answers at once;
	one that does not runs to completion inside a single between-frame action, where
	the render loop is blocked and the measurement is clean."
	| world benchmark |
	benchmark := self new.
	world := SRWorld current.
	world ifNil: [^ self openWorkspaceOn: benchmark run].
	benchmark needsFrames
		ifTrue: [world addDeferredFrameMessage: [benchmark start]]
		ifFalse: [world addDeferredFrameMessage: [self openWorkspaceOn: benchmark run]].
	^ nil
]

{
	#category : #stopping,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 18:28'
}
SRBenchmark class >> showStopButton [
	"A panel rather than a menu row: a benchmark that has driven the world to 12 fps
	is exactly when opening a menu is least pleasant."
	| world |
	world := SRWorld current.
	(world isNil or: [StopButton notNil]) ifTrue: [^ StopButton].
	StopButton := SRBenchmarkStopSign new
		name: 'BenchmarkStop';
		position: 0 @ 1.6m @ -1.2m;
		yourself.
	world addDeferredFrameMessage: [world addChild: StopButton].
	^ StopButton
]

{
	#category : #stopping,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 18:28'
}
SRBenchmark class >> stopButtonLabel: aString [
	| world button |
	button := StopButton ifNil: [^ self].
	world := SRWorld current ifNil: [^ self].
	world addDeferredFrameMessage: [button label: aString].
]

{
	#category : #running,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 17:15'
}
SRBenchmark >> annotate: aPoint [
	"Runs after the measured region and before #tearDownParameter:, so fixtures are
	still in place and nothing it does is counted."
]

{
	#category : #reporting,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 17:15'
}
SRBenchmark >> asDictionary [
	| names |
	names := self class counterNames.
	^ Dictionary newFrom: {
		'benchmark' -> self title.
		'parameterName' -> self parameterName.
		'unit' -> self unit.
		'takenAt' -> DateAndTime now printString.
		'points' -> (self points collect: [:point | | counters |
			counters := Dictionary new.
			point counters keysAndValuesDo: [:index :delta |
				counters at: (names at: index ifAbsent: [index printString]) put: delta].
			Dictionary newFrom: {
				'parameter' -> point parameter.
				'iterations' -> point iterations.
				'micros' -> point micros.
				'value' -> point value asFloat.
				'counters' -> counters.
				'details' -> (Dictionary newFrom:
					(point details associations collect: [:a | a key asString -> a value])) }]) asArray }
]

{
	#category : #reporting,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 17:13'
}
SRBenchmark >> asJsonString [
	^ Json render: self asDictionary
]

{
	#category : #reporting,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 17:55'
}
SRBenchmark >> columnNotes [
	"Keyed by the column header, so a subclass that adds columns adds notes the same
	way and the legend stays in step with #reportColumns."
	^ Dictionary newFrom: {
		self parameterName -> self parameterNote.
		self unit -> 'cost of one operation: ms divided by the iteration count'.
		'ms' -> 'total wall time of the measured region'.
		'scav' -> 'scavenges during the region (vmParameterAt: 9): young-space collections'.
		'gc ms' -> 'VM time in GC (p10). Counted in whole ms, so 0 means under 1 ms in total'.
		'tenured' -> 'objects promoted from young to old space (p11). Nonzero means something survived'.
		'alloc KB' -> 'bytes allocated in object memory (p34). Churn, not retention'.
		'old KB' -> 'old-space growth (p1). Nonzero means the heap really grew' }
]

{
	#category : #measuring,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 17:12'
}
SRBenchmark >> counterDeltasFrom: before to: after [
	| indices deltas |
	indices := self class counterIndices.
	deltas := Dictionary new.
	1 to: indices size do: [:i |
		deltas at: (indices at: i) put: (after at: i) - (before at: i)].
	^ deltas
]

{
	#category : #reporting,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 17:55'
}
SRBenchmark >> description [
	^ 'No description.'
]

{
	#category : #testing,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 17:12'
}
SRBenchmark >> isRunnable [
	^ self needsWorld not or: [self world notNil]
]

{
	#category : #configuring,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 17:12'
}
SRBenchmark >> iterationsFor: aParameter [
	"How many times #runParameter: repeats the unit of work, used to turn elapsed
	time into a per-operation figure."
	^ 1
]

{
	#category : #reporting,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 17:55'
}
SRBenchmark >> legend [
	| headers notes width |
	headers := self reportRows first.
	notes := self columnNotes.
	width := headers inject: 0 into: [:max :each | max max: each size].
	^ String streamContents: [:s |
		s nextPutAll: 'Columns'; cr.
		headers do: [:each |
			s nextPutAll: '  '; nextPutAll: (each padded: #right to: width with: $ );
				nextPutAll: '  ';
				nextPutAll: (notes at: each ifAbsent: ['']);
				cr]]
]

{
	#category : #configuring,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 17:31'
}
SRBenchmark >> needsFrames [
	"True when the run only progresses while the render loop keeps stepping, which
	decides where the menu action may run it. See SRBenchmark class>>runFromMenu."
	^ false
]

{
	#category : #configuring,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 17:12'
}
SRBenchmark >> needsWorld [
	^ false
]

{
	#category : #configuring,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 17:12'
}
SRBenchmark >> parameterName [
	^ 'n'
]

{
	#category : #reporting,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 17:55'
}
SRBenchmark >> parameterNote [
	^ 'the parameter this row was run at; one row per value of #parameters'
]

{
	#category : #configuring,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 17:12'
}
SRBenchmark >> parameters [
	^ #(1)
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 17:12'
}
SRBenchmark >> points [
	^ points ifNil: [#()]
]

{
	#category : #reporting,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 17:13'
}
SRBenchmark >> printNumber: aNumber [
	aNumber isInteger ifTrue: [^ aNumber printString].
	^ aNumber asFloat printShowingDecimalPlaces: 3
]

{
	#category : #measuring,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 17:12'
}
SRBenchmark >> readCountersInto: anArray [
	"Fills a caller-supplied array so that the reading itself allocates nothing and
	does not show up in the bytesAllocated delta it is taken to measure."
	| indices |
	indices := self class counterIndices.
	1 to: indices size do: [:i |
		anArray at: i put: ((Smalltalk vmParameterAt: (indices at: i)) ifNil: [0])].
	^ anArray
]

{
	#category : #reporting,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 17:55'
}
SRBenchmark >> report [
	^ String streamContents: [:s |
		s nextPutAll: '### '; nextPutAll: self title; cr; cr.
		s nextPutAll: self description; cr; cr.
		s nextPutAll: self table; cr.
		s nextPutAll: self legend]
]

{
	#category : #reporting,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 17:13'
}
SRBenchmark >> reportColumns [
	^ {
		self parameterName -> [:p | p parameter printString].
		self unit -> [:p | self printNumber: p value].
		'ms' -> [:p | self printNumber: p micros / 1000.0].
		'scav' -> [:p | p scavenges printString].
		'gc ms' -> [:p | (p counterAt: 10) printString].
		'tenured' -> [:p | p tenures printString].
		'alloc KB' -> [:p | (p bytesAllocated // 1024) printString].
		'old KB' -> [:p | ((p counterAt: 1) // 1024) printString] }
]

{
	#category : #reporting,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 17:41'
}
SRBenchmark >> reportRows [
	| columns |
	columns := self reportColumns.
	^ (Array with: (columns collect: [:each | each key]))
		, (self points asArray collect: [:point |
			columns collect: [:each | each value value: point]])
]

{
	#category : #running,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 18:25'
}
SRBenchmark >> run [
	"The stop button is put up for the whole run and taken down whatever happens, so a
	run abandoned halfway still leaves the world as it was found."
	| all point |
	self isRunnable ifFalse: [^ self error: self class name, ' needs a running SRWorld'].
	SRBenchmark clearStop.
	self showsStopButton ifTrue: [SRBenchmark showStopButton].
	all := self parameters asArray.
	[points := OrderedCollection new.
	all withIndexDo: [:each :i |
		SRBenchmark isStopRequested ifTrue: [^ self].
		SRBenchmark stopButtonLabel: 'STOP  ', self title, '  ', i printString, '/',
			all size printString, '  ', self parameterName, '=', each printString.
		point := self runAt: each.
		SRBenchmark isStopRequested ifTrue: [^ self].
		points add: point].
	points := points asArray]
		ensure: [SRBenchmark hideStopButton].
	^ self
]

{
	#category : #running,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 18:37'
}
SRBenchmark >> runAt: aParameter [
	"Times its own phases into the point, because where a long run spends its time is
	otherwise invisible: the label only moves between parameters, so a slow set-up and
	a slow measurement look identical from outside."
	| before after start stop reported point entered setUpDone tornDown |
	before := Array new: self class counterIndices size.
	after := before copy.
	entered := Time utcMicrosecondClock.
	self setUpParameter: aParameter.
	setUpDone := Time utcMicrosecondClock.
	[self readCountersInto: before.
	start := Time utcMicrosecondClock.
	reported := self runParameter: aParameter.
	stop := Time utcMicrosecondClock.
	self readCountersInto: after.
	point := SRBenchmarkPoint new
		parameter: aParameter;
		iterations: (self iterationsFor: aParameter);
		micros: stop - start;
		value: reported;
		counters: (self counterDeltasFrom: before to: after);
		yourself.
	self annotate: point]
		ensure: [
			self tearDownParameter: aParameter.
			tornDown := Time utcMicrosecondClock.
			point ifNotNil: [point
				detailAt: #setUpMillis put: setUpDone - entered / 1000.0;
				detailAt: #tearDownMillis put: tornDown - stop / 1000.0;
				detailAt: #pointMillis put: tornDown - entered / 1000.0]].
	^ point
]

{
	#category : #running,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 17:12'
}
SRBenchmark >> runParameter: aParameter [
	self subclassResponsibility
]

{
	#category : #running,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 17:12'
}
SRBenchmark >> setUpParameter: aParameter [
	"Build fixtures here, not in #runParameter:, so they are outside the measured
	region."
]

{
	#category : #configuring,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 18:18'
}
SRBenchmark >> showsStopButton [
	"Only benchmarks that let the world keep stepping. The others run inside one
	between-frame action with the render loop blocked, so there is no frame in which
	a button could be drawn, let alone clicked."
	^ self needsFrames
]

{
	#category : #reporting,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 17:55'
}
SRBenchmark >> table [
	^ self class renderTable: self reportRows
]

{
	#category : #running,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 17:12'
}
SRBenchmark >> tearDownParameter: aParameter [
]

{
	#category : #reporting,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 17:12'
}
SRBenchmark >> title [
	^ self class name
]

{
	#category : #configuring,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 17:12'
}
SRBenchmark >> unit [
	^ 'us'
]

{
	#category : #configuring,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 17:12'
}
SRBenchmark >> world [
	"Never creates one. A benchmark that cannot find a running world is skipped."
	^ SRWorld current
]
