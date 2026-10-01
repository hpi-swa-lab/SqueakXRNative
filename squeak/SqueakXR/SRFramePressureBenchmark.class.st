"
Allocation and scavenge pressure of the running world with no fixture at all: the
baseline every other frame-sampling benchmark is read against.

Its parameter is the number of frames watched rather than a fixture size, so it is
the one subclass where #framesFor: answers the parameter itself.
"
Class {
	#name : #SRFramePressureBenchmark,
	#superclass : #SRFrameSamplingBenchmark,
	#category : #'SqueakXR-Benchmarks',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #menu,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 17:52'
}
SRFramePressureBenchmark class >> xrMenuRun: aMenu [
	<xrMenu: #(world profile benchmarks) label: 'Frame pressure' priority: 222>
	^ self runFromMenu
]

{
	#category : #reporting,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 17:56'
}
SRFramePressureBenchmark >> description [
	^ 'Allocation and scavenge pressure of the already running world, sampled once
per frame from between-frame actions. Nothing is added to the world and
nothing is changed: each sample is four VM counter reads.
Frames per scavenge below one means a single frame allocates more than eden,
so a collection lands mid-frame whatever the frame boundary does. This is the
baseline for the prediction that removing RlColor/RlVector3 allocation per
draw call raises the figure above one.'
]

{
	#category : #configuring,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 18:05'
}
SRFramePressureBenchmark >> framesFor: aParameter [
	^ aParameter
]

{
	#category : #configuring,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 17:14'
}
SRFramePressureBenchmark >> parameterName [
	^ 'frames'
]

{
	#category : #reporting,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 17:56'
}
SRFramePressureBenchmark >> parameterNote [
	^ 'frames asked for; the run waits for that many between-frame actions'
]

{
	#category : #configuring,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 17:14'
}
SRFramePressureBenchmark >> parameters [
	^ #(60 300)
]
