"
Abstract benchmark that watches the already running world and reports frame time
and scavenge pressure. Subclasses add a fixture in #installFixture: and undo it in
#removeFixture:.

Driven entirely from SRWorld>>addDeferredFrameMessage:, one #stepFrame per frame,
as a state machine. There is no benchmark process and nothing waits.

That is not a style preference. The earlier version ran on a tool process at
priority 30 and polled for completion with a 10 ms Delay. With 3000 cubes in the
world the render loop at priority 40 is runnable almost continuously, so the tool
process was not scheduled for tens of seconds: all ten samples landed inside
300 ms and the point still took 27 s, because nothing could run to notice they had.
A benchmark that shares a process with what it measures cannot be starved by it.

Each frame does exactly one thing: install the fixture, take one sample, mutate
the fixture, or finish a point. Since every step already runs at a frame boundary,
fixture changes need no synchronisation.
"
Class {
	#name : #SRFrameSamplingBenchmark,
	#superclass : #SRBenchmark,
	#instVars : [
		'frameMicros',
		'frameBytes',
		'frameScavenges',
		'sampleIndex',
		'frameLimit',
		'installMicros',
		'stillStats',
		'changingStats',
		'state',
		'allParameters',
		'paramIndex',
		'currentParameter',
		'before',
		'after',
		'enteredMicros',
		'setUpDoneMicros',
		'startMicros',
		'stopMicros',
		'lastMutationMicros'
	],
	#category : #'SqueakXR-Benchmarks',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #stepping,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 18:41'
}
SRFrameSamplingBenchmark >> abandon [
	"Stop pressed mid-point: the fixture of the point in flight is still in the world."
	currentParameter ifNotNil: [self removeFixture: currentParameter].
	state := #done.
	self finish.
]

{
	#category : #running,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 18:41'
}
SRFrameSamplingBenchmark >> annotate: aPoint [
	aPoint detailAt: #createMillis put: installMicros / 1000.0.
	stillStats ifNil: [^ self].
	aPoint detailAt: #framesSampled put: sampleIndex.
	stillStats keysAndValuesDo: [:k :v | aPoint detailAt: ('still', k) asSymbol put: v].
	changingStats ifNotNil: [
		changingStats keysAndValuesDo: [:k :v | aPoint detailAt: ('changing', k) asSymbol put: v]].
]

{
	#category : #results,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 18:04'
}
SRFrameSamplingBenchmark >> bytesPerFrame [
	^ ((frameBytes at: sampleIndex) - (frameBytes at: 1)) / (sampleIndex - 1)
]

{
	#category : #reporting,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 18:37'
}
SRFrameSamplingBenchmark >> columnNotes [
	^ super columnNotes
		at: 'point ms' put: 'wall time for this whole row: setup plus measurement plus teardown';
		at: 'setup ms' put: 'setup including the wait for a frame boundary';
		at: 'create ms' put: 'the fixture build alone, timed inside the frame boundary';
		at: 'tear ms' put: 'teardown: removing the fixture again';
		at: 'frames' put: 'frames actually sampled. Below the asked-for number means the pass gave up';
		at: 'still ms' put: 'median frame time with the fixture present and untouched';
		at: 'still fps' put: '1000 / still ms';
		at: 'still max ms' put: 'worst frame of the still pass. A lone spike is the outlier worth chasing';
		at: 'chg ms' put: 'median frame time while the fixture is changed every ', self mutationInterval printString, ' ms';
		at: 'chg fps' put: '1000 / chg ms. The gap to still fps is the cost of the change, not of the objects';
		at: 'alloc KB/frame' put: 'object memory allocated per frame during the still pass (p34 delta)';
		at: 'frames/scav' put: 'frames between two scavenges. Below 1 means one frame outgrows eden';
		yourself
]

{
	#category : #results,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 18:04'
}
SRFrameSamplingBenchmark >> deltasOf: anArray [
	^ (2 to: sampleIndex) collect: [:i | (anArray at: i) - (anArray at: i - 1)]
]

{
	#category : #stepping,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 18:41'
}
SRFrameSamplingBenchmark >> finish [
	state := #done.
	points := points ifNil: [#()] ifNotNil: [points asArray].
	SRBenchmark hideStopButton.
	points isEmpty ifFalse: [SRBenchmark openWorkspaceOn: self].
]

{
	#category : #results,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 18:04'
}
SRFrameSamplingBenchmark >> frameMillis [
	^ (self deltasOf: frameMicros) collect: [:each | each / 1000.0]
]

{
	#category : #configuring,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 18:03'
}
SRFrameSamplingBenchmark >> framesFor: aParameter [
	^ 60
]

{
	#category : #results,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 18:04'
}
SRFrameSamplingBenchmark >> framesPerScavenge [
	| scavenges |
	scavenges := (frameScavenges at: sampleIndex) - (frameScavenges at: 1).
	scavenges = 0 ifTrue: [^ sampleIndex].
	^ (sampleIndex - 1) / scavenges
]

{
	#category : #fixture,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 18:03'
}
SRFrameSamplingBenchmark >> installFixture: aParameter [
	"Runs at a frame boundary. Whatever this adds, #removeFixture: must take away."
]

{
	#category : #configuring,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 18:03'
}
SRFrameSamplingBenchmark >> iterationsFor: aParameter [
	^ self framesFor: aParameter
]

{
	#category : #fixture,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 18:04'
}
SRFrameSamplingBenchmark >> mutateFixture: aParameter [
	"Runs at a frame boundary, every #mutationInterval ms during the changing phase."
]

{
	#category : #configuring,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 18:04'
}
SRFrameSamplingBenchmark >> mutatesFixture [
	^ false
]

{
	#category : #configuring,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 18:04'
}
SRFrameSamplingBenchmark >> mutationInterval [
	^ 100
]

{
	#category : #configuring,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 18:03'
}
SRFrameSamplingBenchmark >> needsFrames [
	^ true
]

{
	#category : #configuring,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 18:03'
}
SRFrameSamplingBenchmark >> needsWorld [
	^ true
]

{
	#category : #stepping,
	#'squeak_changestamp' : 'MCPServer 9/21/2026 16:17'
}
SRFrameSamplingBenchmark >> performStep [
	state == #nextParameter ifTrue: [^ self stepNextParameter].
	state == #setUp ifTrue: [^ self stepSetUp].
	state == #sampleStill ifTrue: [^ self stepSample].
	state == #startChanging ifTrue: [^ self stepStartChanging].
	state == #sampleChanging ifTrue: [^ self stepSampleChanging].
	state == #finishPoint ifTrue: [^ self stepFinishPoint].
	state := #done.
]

{
	#category : #fixture,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 18:03'
}
SRFrameSamplingBenchmark >> removeFixture: aParameter [
]

{
	#category : #reporting,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 18:37'
}
SRFrameSamplingBenchmark >> reportColumns [
	| columns |
	columns := OrderedCollection new.
	columns
		add: self parameterName -> [:p | p parameter printString];
		add: 'point ms' -> [:p | self printNumber: (p detailAt: #pointMillis)];
		add: 'setup ms' -> [:p | self printNumber: (p detailAt: #setUpMillis)];
		add: 'create ms' -> [:p | self printNumber: (p detailAt: #createMillis)];
		add: 'tear ms' -> [:p | self printNumber: (p detailAt: #tearDownMillis)];
		add: 'frames' -> [:p | (p detailAt: #stillframes) printString];
		add: 'still ms' -> [:p | self printNumber: (p detailAt: #stillmedianMillis)];
		add: 'still fps' -> [:p | self printNumber: (p detailAt: #stillfps)];
		add: 'still max ms' -> [:p | self printNumber: (p detailAt: #stillmaxMillis)].
	self mutatesFixture ifTrue: [
		columns
			add: 'chg ms' -> [:p | self printNumber: (p detailAt: #changingmedianMillis)];
			add: 'chg fps' -> [:p | self printNumber: (p detailAt: #changingfps)]].
	columns
		add: 'alloc KB/frame' -> [:p | self printNumber: (p detailAt: #stillbytesPerFrame) / 1024];
		add: 'frames/scav' -> [:p | self printNumber: (p detailAt: #stillframesPerScavenge)];
		add: 'scav' -> [:p | p scavenges printString];
		add: 'tenured' -> [:p | p tenures printString].
	^ columns asArray
]

{
	#category : #running,
	#'squeak_changestamp' : 'MCPServer 9/21/2026 16:17'
}
SRFrameSamplingBenchmark >> sampleFrame [
	"Reads and stores only, so sampling does not show up in the allocation figures
	it is taking. One sample is one frame by construction: the caller is itself the
	frame's deferred action."

	| i |
	i := sampleIndex + 1.
	i > frameLimit ifTrue: [^ self].
	frameMicros at: i put: Time utcMicrosecondClock.
	frameBytes at: i put: (Smalltalk vmParameterAt: 34).
	frameScavenges at: i put: (Smalltalk vmParameterAt: 9).
	sampleIndex := i.
]

{
	#category : #stepping,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 18:40'
}
SRFrameSamplingBenchmark >> scheduleStep [
	| world |
	world := self world ifNil: [^ self finish].
	world addDeferredFrameMessage: [self stepFrame].
]

{
	#category : #stepping,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 18:40'
}
SRFrameSamplingBenchmark >> start [
	"Answers immediately. The run proceeds one step per frame and opens its workspace
	when it is done."
	self isRunnable ifFalse: [^ self error: self class name, ' needs a running SRWorld'].
	SRBenchmark clearStop.
	self showsStopButton ifTrue: [SRBenchmark showStopButton].
	allParameters := self parameters asArray.
	paramIndex := 0.
	points := OrderedCollection new.
	state := #nextParameter.
	self scheduleStep.
]

{
	#category : #results,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 18:04'
}
SRFrameSamplingBenchmark >> statsFromSamples [
	| millis sorted median |
	millis := self frameMillis asArray.
	sorted := millis asSortedCollection asArray.
	median := sorted at: sorted size + 1 // 2.
	^ Dictionary newFrom: {
		#frames -> sampleIndex.
		#medianMillis -> median.
		#maxMillis -> sorted last.
		#fps -> (median > 0 ifTrue: [1000.0 / median] ifFalse: [0]).
		#bytesPerFrame -> self bytesPerFrame.
		#framesPerScavenge -> self framesPerScavenge }
]

{
	#category : #stepping,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 18:40'
}
SRFrameSamplingBenchmark >> stepFinishPoint [
	| point tearStart tornDown |
	stopMicros := Time utcMicrosecondClock.
	after := self readCountersInto: (Array new: self class counterIndices size).
	point := SRBenchmarkPoint new
		parameter: currentParameter;
		iterations: (self iterationsFor: currentParameter);
		micros: stopMicros - startMicros;
		value: (stillStats at: #fps);
		counters: (self counterDeltasFrom: before to: after);
		yourself.
	self annotate: point.
	tearStart := Time utcMicrosecondClock.
	self removeFixture: currentParameter.
	tornDown := Time utcMicrosecondClock.
	point
		detailAt: #setUpMillis put: setUpDoneMicros - enteredMicros / 1000.0;
		detailAt: #tearDownMillis put: tornDown - tearStart / 1000.0;
		detailAt: #pointMillis put: tornDown - enteredMicros / 1000.0.
	points add: point.
	state := #nextParameter.
]

{
	#category : #stepping,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 18:40'
}
SRFrameSamplingBenchmark >> stepFrame [
	SRBenchmark isStopRequested ifTrue: [^ self abandon].
	self performStep.
	state == #done ifTrue: [^ self finish].
	self scheduleStep.
]

{
	#category : #stepping,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 18:40'
}
SRFrameSamplingBenchmark >> stepNextParameter [
	paramIndex := paramIndex + 1.
	paramIndex > allParameters size ifTrue: [^ state := #done].
	currentParameter := allParameters at: paramIndex.
	SRBenchmark stopButtonLabel: 'STOP  ', self title, '  ', paramIndex printString,
		'/', allParameters size printString, '  ', self parameterName, '=',
		currentParameter printString.
	state := #setUp.
]

{
	#category : #stepping,
	#'squeak_changestamp' : 'MCPServer 9/21/2026 16:17'
}
SRFrameSamplingBenchmark >> stepSample [
	self sampleFrame.
	sampleIndex < frameLimit ifTrue: [^ self].
	stillStats ifNil: [stillStats := self statsFromSamples] ifNotNil: [changingStats := self statsFromSamples].
	state := (self mutatesFixture and: [changingStats isNil])
		ifTrue: [#startChanging]
		ifFalse: [#finishPoint].

]

{
	#category : #stepping,
	#'squeak_changestamp' : 'MCPServer 9/21/2026 16:17'
}
SRFrameSamplingBenchmark >> stepSampleChanging [
	| now |
	now := Time utcMicrosecondClock.
	now - lastMutationMicros >= (self mutationInterval * 1000) ifTrue: [
		lastMutationMicros := now.
		self mutateFixture: currentParameter].
	self stepSample.
]

{
	#category : #stepping,
	#'squeak_changestamp' : 'MCPServer 9/21/2026 16:17'
}
SRFrameSamplingBenchmark >> stepSetUp [
	enteredMicros := Time utcMicrosecondClock.
	frameLimit := self framesFor: currentParameter.
	frameMicros := Array new: frameLimit withAll: 0.
	frameBytes := Array new: frameLimit withAll: 0.
	frameScavenges := Array new: frameLimit withAll: 0.
	sampleIndex := 0.
	stillStats := changingStats := nil.
	installMicros := Time utcMicrosecondClock.
	self installFixture: currentParameter.
	installMicros := Time utcMicrosecondClock - installMicros.
	setUpDoneMicros := Time utcMicrosecondClock.
	before := self readCountersInto: (Array new: self class counterIndices size).
	startMicros := Time utcMicrosecondClock.
	state := #sampleStill.
]

{
	#category : #stepping,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 18:40'
}
SRFrameSamplingBenchmark >> stepStartChanging [
	sampleIndex := 0.
	lastMutationMicros := 0.
	state := #sampleChanging.
]

{
	#category : #configuring,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 18:05'
}
SRFrameSamplingBenchmark >> unit [
	^ 'fps'
]
