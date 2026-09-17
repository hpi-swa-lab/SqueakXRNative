"
Cost of building the external structures the renderer passes to raylib, against
an ordinary Array of the same width as a control.

The parameter is the conversion, not a size: what matters is the ratio between
the columns. The cost is wall clock on the calling thread, not GC pressure, so
the counter deltas here are expected to be small and are recorded to show that.
"
Class {
	#name : #SRFFIConversionBenchmark,
	#superclass : #SRBenchmark,
	#instVars : [
		'color',
		'vector'
	],
	#category : #'SqueakXR-Benchmarks',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #menu,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 17:52'
}
SRFFIConversionBenchmark class >> xrMenuRun: aMenu [
	<xrMenu: #(world profile benchmarks) label: 'FFI conversion' priority: 221>
	^ self runFromMenu
]

{
	#category : #reporting,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 17:56'
}
SRFFIConversionBenchmark >> description [
	^ 'Cost of building the external structures the renderer hands to raylib.
Each row repeats one conversion ', self repeats printString, ' times and divides.
#arrayNew is the control: an ordinary Array of the same width, allocated
but never converted. What matters is the ratio between the rows, not the
absolute figures -- those move with whatever else the image is doing.'
]

{
	#category : #configuring,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 17:13'
}
SRFFIConversionBenchmark >> iterationsFor: aParameter [
	^ self repeats
]

{
	#category : #configuring,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 17:13'
}
SRFFIConversionBenchmark >> parameterName [
	^ 'conversion'
]

{
	#category : #reporting,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 17:56'
}
SRFFIConversionBenchmark >> parameterNote [
	^ 'which conversion was repeated; not a size'
]

{
	#category : #configuring,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 17:13'
}
SRFFIConversionBenchmark >> parameters [
	^ #(#asRlColor #asRlVector #arrayNew)
]

{
	#category : #configuring,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 17:13'
}
SRFFIConversionBenchmark >> repeats [
	^ 10000
]

{
	#category : #running,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 17:13'
}
SRFFIConversionBenchmark >> runParameter: aParameter [
	aParameter caseOf: {
		[#asRlColor] -> [self repeats timesRepeat: [color asRlColor]].
		[#asRlVector] -> [self repeats timesRepeat: [vector asRlVector]].
		[#arrayNew] -> [self repeats timesRepeat: [Array new: 6]] }.
	^ nil
]

{
	#category : #running,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 17:13'
}
SRFFIConversionBenchmark >> setUpParameter: aParameter [
	color := Color r: 0.2 g: 0.4 b: 0.6.
	vector := 1 @ 2 @ 3.
]
