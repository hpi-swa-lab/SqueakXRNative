"
The slab shown while a long benchmark runs: it names the benchmark and the point
being measured, and a raycast on it asks the run to stop.

A plain object with its own #collisionGeometry rather than an SRMorphPanel holding
a button. The Morphic route needs the panel's event plumbing to deliver a click to
the morph, which does not happen here; a collision box and #onRaycast: is the
mechanism SRMenuItem already uses and it is two methods.
"
Class {
	#name : #SRBenchmarkStopSign,
	#superclass : #SRActionSign,
	#category : #'SqueakXR-Benchmarks',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #initialization,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:10'
}
SRBenchmarkStopSign >> initialize [
	super initialize.
	self label: 'STOP'.
]

{
	#category : #collisions,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 18:29'
}
SRBenchmarkStopSign >> onRaycast: aSRRayIntersectionResult [
	"Takes itself down here rather than leaving it to the run's ensure:, which may be
	several frames away inside a wait. A sign still standing reads as a missed click.
	Removal is deferred because this runs inside the world's raycast traversal."
	| world |
	self label: 'stopping...'.
	SRBenchmark requestStop.
	SRBenchmark forgetStopButton.
	world := self world.
	world ifNotNil: [world addDeferredFrameMessage: [world removeChild: self]].
]
