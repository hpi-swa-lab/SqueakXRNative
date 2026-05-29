"
A demo SRMeshObject with an animated grid SRMesh. Survives image save/restart because its mesh and texture inherit SRMesh / SRTexture's lifecycle hooks.

ivars:
  time           accumulated milliseconds since start
  amplitude      max wave height in world units (default 0.3)
  updateNormals  true to recompute and re-upload normals each frame (default true)
  phaseRate      multiplier on time inside the sin() argument (default 0.0001875)
"
Class {
	#name : #SRHeightfield,
	#superclass : #SRMeshObject,
	#instVars : [
		'time',
		'amplitude',
		'updateNormals',
		'phaseRate'
	],
	#category : #'SqueakXR-Objects',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 5/28/2026 17:37'
}
SRHeightfield >> amplitude: aFloat [
	amplitude := aFloat asFloat
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'MCPServer 5/28/2026 17:37'
}
SRHeightfield >> initializeCols: aCols rows: aRows extent: aPoint [
	"Build a flat grid mesh and a procedurally generated checker texture (blue/green)."

	| tex |
	self mesh: (SRMesh grid: aCols by: aRows extent: aPoint).
	tex := SRTexture
		checker: 8 @ 8
		color1: Color blue
		color2: Color green
		extent: 128 @ 128.
	self material: (SRMaterial withTexture: tex).
	time := 0.0.
	amplitude := 0.3.
	updateNormals := true.
	phaseRate := 0.0001875.
	^ self
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 5/28/2026 17:37'
}
SRHeightfield >> phaseRate: aFloat [
	phaseRate := aFloat asFloat
]

{
	#category : #lifecycle,
	#'squeak_changestamp' : 'MCPServer 5/28/2026 17:37'
}
SRHeightfield >> step: deltaTime [
	"Animate the height grid with a travelling sine wave."

	| m cols rows buf k vOff x z y amp t |
	super step: deltaTime.
	time := (time ifNil: [0.0]) + deltaTime.
	amp := amplitude ifNil: [0.3].
	t := time * (phaseRate ifNil: [0.0001875]).
	m := self mesh.
	m ifNil: [^ self].
	cols := m cols.
	rows := m rows.
	buf := m vertexBuffer.
	0 to: rows - 1 do: [:r |
		0 to: cols - 1 do: [:c |
			k := r * cols + c.
			vOff := k * 12.
			x := buf floatAt: vOff + 1.
			z := buf floatAt: vOff + 9.
			y := amp * ((x * 2 + (z * 2) + t) sin).
			buf floatAt: vOff + 5 put: y]].
	m flushVertices.
	(updateNormals ifNil: [true]) ifTrue: [
		m recomputeGridNormals.
		m flushNormals]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 5/28/2026 17:37'
}
SRHeightfield >> updateNormals: aBoolean [
	updateNormals := aBoolean
]
