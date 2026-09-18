"
The SRCubeRenderBenchmark sweep with SRFastCube instead of SRCube, so the two
can be run one after the other and their curves compared directly. Everything
except the cube class is inherited, including the parameter sweep.
"
Class {
	#name : #SRFastCubeRenderBenchmark,
	#superclass : #SRCubeRenderBenchmark,
	#category : #'SqueakXR-Benchmarks',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #menu,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 10:41'
}
SRFastCubeRenderBenchmark class >> xrMenuRun: aMenu [
	<xrMenu: #(world profile benchmarks) label: 'Fast cube rendering' priority: 224>
	^ self runFromMenu
]

{
	#category : #configuring,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 10:40'
}
SRFastCubeRenderBenchmark >> cubeClass [
	^ SRFastCube.
]

{
	#category : #reporting,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 10:41'
}
SRFastCubeRenderBenchmark >> description [
	^ 'Frame cost of N SRFastCubes, the same sweep as Cube rendering so the two
tables line up row by row.
SRFastCube keeps its RlColor and RlMatrix and mutates them, and draws from one
shared GenMeshCube, so a still frame allocates nothing per cube.
The prediction is that alloc KB/frame stops rising with cubes and frames/scav
goes back above 1.'
]
