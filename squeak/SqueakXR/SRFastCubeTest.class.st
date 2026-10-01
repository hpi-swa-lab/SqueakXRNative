"
Covers the caching SRFastCube exists for: that the RlColor and the RlMatrix
are the same objects from frame to frame, and that their contents still agree
with #asRlColor and #asRlMatrix. Nothing here touches the GPU.
"
Class {
	#name : #SRFastCubeTest,
	#superclass : #TestCase,
	#instVars : [
		'cube'
	],
	#category : #'SqueakXR-Tests-Objects',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #asserting,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 10:44'
}
SRFastCubeTest >> bytesOf: anExternalStructure [
	^ anExternalStructure getHandle asArray.
]

{
	#category : #running,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 10:44'
}
SRFastCubeTest >> setUp [
	super setUp.
	cube := SRFastCube new.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 10:44'
}
SRFastCubeTest >> testColorMatchesAsRlColor [
	cube color: (Color h: 200 s: 0.7 v: 0.9).
	self
		assert: (self bytesOf: cube color asRlColor)
		equals: (self bytesOf: cube rlColor).
	self
		assert: (self bytesOf: cube color muchDarker asRlColor)
		equals: (self bytesOf: cube rlWireColor).
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 10:44'
}
SRFastCubeTest >> testColorStructIsReused [
	| first |
	first := cube rlColor.
	cube color: Color blue.
	self assert: first == cube rlColor.
	self assert: (self bytesOf: Color blue asRlColor) equals: (self bytesOf: first).
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 10:44'
}
SRFastCubeTest >> testGlMatrixIsTransposed [
	cube position: 1 @ 2 @ 3.
	cube localRotation: (Quaternion angle: 0.4 axis: (Vector3 x: 0 y: 1 z: 0)).
	self
		assert: cube globalTransform transposed asArray
		equals: cube glMatrix asArray.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 10:44'
}
SRFastCubeTest >> testIsCube [
	self assert: cube isCube.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 10:44'
}
SRFastCubeTest >> testIsRendered [
	"SRWorld skips objects that do not define #renderOn: themselves."

	self assert: cube isRendering.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:21'
}
SRFastCubeTest >> testMatrixFollowsTheParent [
	| parent |
	parent := SRObject new.
	parent addChild: cube.
	cube glMatrix.
	parent position: 0 @ 0 @ 10.
	self
		assert: cube globalTransform transposed asArray
		equals: cube glMatrix asArray.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:21'
}
SRFastCubeTest >> testMatrixStructIsReused [
	| first |
	cube position: 1 @ 2 @ 3.
	first := cube glMatrix.
	cube position: 4 @ 5 @ 6.
	self assert: first == cube glMatrix.
	self assert: first == cube glMatrix.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 10:44'
}
SRFastCubeTest >> testRenderAsksForAFastCube [
	| renderer |
	renderer := SRRecordingRenderer new.
	cube renderOn: renderer.
	self assert: 1 equals: renderer calls size.
	self assert: #renderFastCube: equals: renderer calls first selector.
	self assert: cube == renderer calls first arguments first.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:21'
}
SRFastCubeTest >> testStillCubeAllocatesNothing [
	"The reason the class exists: an unmoved cube costs nothing to prepare for a draw."

	| before after |
	cube position: 1 @ 2 @ 3.
	cube glMatrix.
	before := Smalltalk vmParameterAt: 34.
	1000 timesRepeat: [cube rlColor. cube rlWireColor. cube glMatrix].
	after := Smalltalk vmParameterAt: 34.
	self assert: after - before < 1000.
]
