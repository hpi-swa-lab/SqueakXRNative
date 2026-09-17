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
	#superclass : #SRObject,
	#instVars : [
		'size',
		'textField'
	],
	#category : #'SqueakXR-Benchmarks',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #collisions,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 18:28'
}
SRBenchmarkStopSign >> collisionGeometry [
	^ SRCollisionBox new
		center: self globalTranslation;
		halfExtents: self globalScale * size / 2;
		rotation: self globalRotation;
		object: self.
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 18:27'
}
SRBenchmarkStopSign >> initialize [
	super initialize.
	size := 80cm @ 12cm @ 2cm.
	textField := SRTextField new
		text: 'STOP';
		color: Color white;
		scale: 0.012 asVector3;
		rotation: (Quaternion new radiansAngle: Float pi / 2 axis: Vector3 right);
		yourself.
	self addChild: textField.
	self label: 'STOP'.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 18:27'
}
SRBenchmarkStopSign >> label: aString [
	textField text: aString.
	textField position: size x / -2 + 2cm @ (size y / 2 - 1cm) @ (size z / 2 + 1mm).
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

{
	#category : #rendering,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 18:28'
}
SRBenchmarkStopSign >> renderOn: aSRRenderer [
	| transform |
	transform := self globalTransform * (Matrix4x4 withScale: size).
	aSRRenderer
		renderPlainCubeTransformed: transform withColor: (Color r: 0.5 g: 0.05 b: 0.05);
		renderWireCubeTransformed: transform withColor: Color white.
]
