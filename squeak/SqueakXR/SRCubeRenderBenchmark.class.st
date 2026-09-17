"
Frame cost of N cubes in the running world, swept 0 to 10000 in steps of 1000.

The cubes hang off one container SRObject rather than off the world. SRObject>>removeChild: scans #children and notifies the world per call, so removing
N cubes one at a time is quadratic and at N=10000 takes far longer than the
measurement it is cleaning up after. Removing the container is one call.

The lattice is deterministic rather than random so two runs are comparable, and it
sits behind the origin so it does not fill the avatar's view.
"
Class {
	#name : #SRCubeRenderBenchmark,
	#superclass : #SRFrameSamplingBenchmark,
	#instVars : [
		'container'
	],
	#category : #'SqueakXR-Benchmarks',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #menu,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 18:06'
}
SRCubeRenderBenchmark class >> xrMenuRun: aMenu [
	<xrMenu: #(world profile benchmarks) label: 'Cube rendering' priority: 223>
	^ self runFromMenu
]

{
	#category : #reporting,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 18:32'
}
SRCubeRenderBenchmark >> description [
	^ 'Frame cost of N cubes in the running world, swept 0 to 10000 in steps of 1000.
Each row adds its cubes (create ms), watches the world for ', (self framesFor: nil) printString, ' frames with
nothing touching them, then removes them again. The 0 row is the empty control:
whatever it costs is the world itself, not the cubes.
Read alloc KB/frame against cubes -- if it is linear, the per-frame cost is
allocation per cube and not the draw calls.'
]

{
	#category : #configuring,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 18:32'
}
SRCubeRenderBenchmark >> framesFor: aParameter [
	"Short, because the point of this one is the shape of the curve over eleven
	counts rather than a steady figure at any one of them."
	^ 10
]

{
	#category : #fixture,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 18:25'
}
SRCubeRenderBenchmark >> installFixture: aParameter [
	| side cubes |
	container := SRObject new name: 'BenchCubes'; yourself.
	side := aParameter asFloat sqrt ceiling max: 1.
	cubes := (1 to: aParameter) collect: [:i |
		SRCube new
			color: (Color h: i * 360 / aParameter s: 0.7 v: 0.9);
			position: (i - 1 \\ side - (side / 2)) * 30cm
					@ ((i - 1 // side \\ side) * 30cm)
					@ (0 - 3m - ((i - 1 // (side * side)) * 30cm));
			yourself].
	container addChildren: cubes.
	self world addChild: container.
]

{
	#category : #fixture,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 18:25'
}
SRCubeRenderBenchmark >> mutateFixture: aParameter [
	container children do: [:each | each position: each position + (0 @ 1cm @ 0)].
]

{
	#category : #configuring,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 18:13'
}
SRCubeRenderBenchmark >> mutatesFixture [
	^ false
]

{
	#category : #configuring,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 18:05'
}
SRCubeRenderBenchmark >> parameterName [
	^ 'cubes'
]

{
	#category : #configuring,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 18:05'
}
SRCubeRenderBenchmark >> parameterNote [
	^ 'cubes added to the running world for this row, removed again afterwards'
]

{
	#category : #configuring,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 18:13'
}
SRCubeRenderBenchmark >> parameters [
	^ (0 to: 10000 by: 1000) asArray
]

{
	#category : #fixture,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 18:25'
}
SRCubeRenderBenchmark >> removeFixture: aParameter [
	container ifNil: [^ self].
	self world removeChild: container.
	container := nil.
]
