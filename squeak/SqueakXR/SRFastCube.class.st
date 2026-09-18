"
An SRCube that allocates nothing per frame, for experimenting with the cost
measured by SRCubeRenderBenchmark: 9.5 KB per cube per frame, all of it
ExternalStructure creation in #asRlColor and #asRlVector.

It issues the same raylib calls as SRCube. The difference is that the RlColors,
the transposed matrix and the zero RlVector3 are state rather than fresh
objects, mutated in place. The matrix is rewritten only when #globalTransform
answers a different object, which it does exactly when the transform was
recomputed.

Drawing the cube from one shared GenMeshCube via DrawMesh was tried and is no
faster than the immediate-mode calls, which is why it is not here.
"
Class {
	#name : #SRFastCube,
	#superclass : #SRObject,
	#instVars : [
		'color',
		'rlColor',
		'rlWireColor',
		'glMatrix',
		'cachedGlobalTransform',
		'drawWires'
	],
	#classVars : [
		'SharedZero'
	],
	#category : #'SqueakXR-Benchmarks',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #'shared resources',
	#'squeak_changestamp' : 'MCPServer 9/18/2026 10:39'
}
SRFastCube class >> sharedZero [
	^ SharedZero ifNil: [SharedZero := Vector3 zero asRlVector].
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 10:40'
}
SRFastCube >> color [
	^ color.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 10:40'
}
SRFastCube >> color: aColor [
	color := aColor.
	self writeColor: aColor into: rlColor.
	self writeColor: aColor muchDarker into: rlWireColor.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 10:40'
}
SRFastCube >> drawWires [
	^ drawWires.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 10:40'
}
SRFastCube >> drawWires: aBoolean [
	"SRCube always draws them, so leave this on when comparing against it."

	drawWires := aBoolean.
]

{
	#category : #private,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:21'
}
SRFastCube >> ensureMatrixCurrent [
	"SRObject>>updateGlobalTransform assigns a fresh Matrix4x4, so identity is an
	exact dirty test: same object means the transform was not recomputed."

	| m |
	m := self globalTransform.
	m == cachedGlobalTransform ifTrue: [^ self].
	cachedGlobalTransform := m.
	1 to: 4 do: [:row |
		1 to: 4 do: [:col |
			glMatrix at: col - 1 * 4 + row put: (m at: row - 1 * 4 + col)]].
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:21'
}
SRFastCube >> glMatrix [
	"Transposed, which is what rlMultMatrixf wants."

	self ensureMatrixCurrent.
	^ glMatrix.
]

{
	#category : #initializing,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:30'
}
SRFastCube >> initialize [
	super initialize.
	rlColor := RlColor new.
	rlWireColor := RlColor new.
	glMatrix := Matrix4x4 new.
	drawWires := true.
	self color: Color red.
]

{
	#category : #testing,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 10:40'
}
SRFastCube >> isCube [
	^ true.
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 10:40'
}
SRFastCube >> renderOn: aSRRenderer [
	aSRRenderer renderFastCube: self.
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 10:40'
}
SRFastCube >> rlColor [
	^ rlColor.
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 10:40'
}
SRFastCube >> rlWireColor [
	^ rlWireColor.
]

{
	#category : #private,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 10:40'
}
SRFastCube >> writeColor: aColor into: anRlColor [
	anRlColor
		r: (aColor red * 255) asInteger;
		g: (aColor green * 255) asInteger;
		b: (aColor blue * 255) asInteger;
		a: (aColor alpha * 255) asInteger.
]
