"
Cost of one Time utcMicrosecondClock read, which is the floor below which
SWATimingWrapper cannot usefully time anything: it takes two per call.

The curve is over batch size because the enclosing timesRepeat: is inside the
measured region, so every figure is an upper bound and the small batches show how
much of it is loop overhead.
"
Class {
	#name : #SRClockReadBenchmark,
	#superclass : #SRBenchmark,
	#category : #'SqueakXR-Benchmarks',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #menu,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 17:52'
}
SRClockReadBenchmark class >> xrMenuRun: aMenu [
	<xrMenu: #(world profile benchmarks) label: 'Clock read' priority: 220>
	^ self runFromMenu
]

{
	#category : #reporting,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 17:56'
}
SRClockReadBenchmark >> description [
	^ 'Cost of one Time utcMicrosecondClock read. SWATimingWrapper takes two per
instrumented call, so twice this is the floor below which a wrapper cannot
usefully time a method.
The enclosing timesRepeat: is inside the measured region, so every figure is
an upper bound, and the small batches show how much of it is loop overhead.'
]

{
	#category : #configuring,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 17:13'
}
SRClockReadBenchmark >> iterationsFor: aParameter [
	^ aParameter
]

{
	#category : #configuring,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 17:13'
}
SRClockReadBenchmark >> parameterName [
	^ 'reads'
]

{
	#category : #reporting,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 17:56'
}
SRClockReadBenchmark >> parameterNote [
	^ 'clock reads in the batch; also the divisor for the us column'
]

{
	#category : #configuring,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 17:13'
}
SRClockReadBenchmark >> parameters [
	^ #(1000 10000 100000)
]

{
	#category : #running,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 17:13'
}
SRClockReadBenchmark >> runParameter: aParameter [
	aParameter timesRepeat: [Time utcMicrosecondClock].
	^ nil
]
