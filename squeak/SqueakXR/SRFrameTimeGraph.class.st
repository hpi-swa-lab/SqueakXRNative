Class {
	#name : #SRFrameTimeGraph,
	#superclass : #SRObject,
	#instVars : [
		'barMatrices',
		'barColors',
		'frameTimes',
		'maxFrames',
		'graphWidth',
		'barDepth',
		'maxFrameTimeMs',
		'fpsCounts',
		'secondAccumulator',
		'secondFrameCount',
		'mode',
		'maxFramesPerSecond',
		'bucketDurationMs',
		'frameTimeBucketSize',
		'frameTimeBucketAccumulator',
		'frameTimeBucketCount',
		'ringIndex',
		'barWidth',
		'leftEdge',
		'rightEdge'
	],
	#category : #'SqueakXR-Objects'
}

{
	#category : #'xr menu',
	#'squeak_changestamp' : 'MCPServer 8/3/2026 13:59'
}
SRFrameTimeGraph class >> xrMenuSpawn: aMenu [
	<xrMenu: #(world debug) label: 'Frame Time Graph' priority: 430>
	| graph |
	graph := self new
		position: aMenu position;
		yourself.
	aMenu world addChild: graph.
	^ graph
]

{
	#category : #private,
	#'squeak_changestamp' : 'MCPServer 8/5/2026 14:43'
}
SRFrameTimeGraph >> advanceRing [
	"Advance the ring index by one, wrapping to the beginning past the end."

	ringIndex := ringIndex \\ maxFrames + 1
]

{
	#category : #private,
	#'squeak_changestamp' : 'MCPServer 8/5/2026 15:04'
}
SRFrameTimeGraph >> applyBar: index value: value x: x [
	"Recompute the local matrix and color for the bar at the given ring
	slot from a data value and a horizontal position."

	| height |
	height := self mode = #frameTime
		ifTrue: [self heightForFrameTime: value]
		ifFalse: [self heightForFramesPerSecond: value].
	barColors at: index put: (self mode = #frameTime
		ifTrue: [self colorForFrameTime: value]
		ifFalse: [self colorForFramesPerSecond: value]).
	barMatrices at: index put: (self barMatrixAtX: x height: height)
]

{
	#category : #private,
	#'squeak_changestamp' : 'MCPServer 8/5/2026 15:11'
}
SRFrameTimeGraph >> barMatrixAtX: x height: height [
	"Build a bar's local-space transform: a unit cube translated to
	(x, height/2, 0) and scaled to (barWidth, height, barDepth). No
	rotation, so the scale can be written straight onto the diagonal of
	the translation matrix."

	^ (Matrix4x4 withOffset: x @ (height / 2.0) @ 0.0)
		setScale: barWidth @ height @ barDepth
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 8/5/2026 14:51'
}
SRFrameTimeGraph >> bucketDurationMs [

	^ bucketDurationMs
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 8/5/2026 14:52'
}
SRFrameTimeGraph >> bucketDurationMs: milliseconds [

	(milliseconds isNumber and: [milliseconds > 0.0]) ifFalse: [
		self error: 'bucketDurationMs must be > 0'].
	bucketDurationMs := milliseconds asFloat.
	secondAccumulator := 0.0.
	secondFrameCount := 0.
	self mode = #framesPerSecond ifTrue: [
		self resetRing.
		self redrawAllBars]
]

{
	#category : #collisions,
	#'squeak_changestamp' : 'MCPServer 5/19/2026 13:26'
}
SRFrameTimeGraph >> collisionGeometry [
	^ SRCollisionBox new
		center: self globalTranslation;
		halfExtents: self globalScale * (graphWidth / 2 @ 0.25 @ (barDepth / 2));
		rotation: self globalRotation;
		object: self.
]

{
	#category : #private,
	#'squeak_changestamp' : 'lege 3/13/2026 16:43'
}
SRFrameTimeGraph >> colorForFrameTime: frameTimeMs [

	| fps |
	frameTimeMs <= 0.0
		ifTrue: [fps := 1000.0]
		ifFalse: [fps := 1000.0 / frameTimeMs].
	^ self colorForSpeedFps: fps
]

{
	#category : #private,
	#'squeak_changestamp' : 'lege 3/13/2026 16:43'
}
SRFrameTimeGraph >> colorForFramesPerSecond: fps [

	^ self colorForSpeedFps: fps
]

{
	#category : #private,
	#'squeak_changestamp' : 'lege 3/13/2026 16:43'
}
SRFrameTimeGraph >> colorForSpeedFps: fps [

	| normalized |
	normalized := self normalizedSpeedForFps: fps.
	^ self interpolatedColorForNormalizedSpeed: normalized
]

{
	#category : #private,
	#'squeak_changestamp' : 'MCPServer 8/5/2026 15:04'
}
SRFrameTimeGraph >> commitDataPoint [
	"A new data value has just been written into the ring at ringIndex.
	Update only the youngest bar (the one at ringIndex): recompute its
	matrix and color and move it to the rightmost slot. Every other bar
	is simply shifted one bar-width to the left. Finally advance the ring."

	| values youngestValue rightX shift |
	values := self mode = #frameTime
		ifTrue: [frameTimes]
		ifFalse: [fpsCounts].
	rightX := rightEdge - (barWidth / 2.0).
	youngestValue := values at: ringIndex.
	shift := barWidth negated @ 0.0 @ 0.0.
	1 to: maxFrames do: [:index |
		index = ringIndex ifFalse: [
			barMatrices at: index put: ((barMatrices at: index) translatedBy: shift)]].
	self applyBar: ringIndex value: youngestValue x: rightX.
	self advanceRing
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 8/5/2026 14:51'
}
SRFrameTimeGraph >> frameTimeBucketSize [

	^ frameTimeBucketSize
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 8/5/2026 14:52'
}
SRFrameTimeGraph >> frameTimeBucketSize: frameCount [

	(frameCount isNumber and: [frameCount > 0]) ifFalse: [
		self error: 'frameTimeBucketSize must be > 0'].
	frameTimeBucketSize := frameCount asInteger max: 1.
	frameTimeBucketAccumulator := 0.0.
	frameTimeBucketCount := 0.
	self mode = #frameTime ifTrue: [
		self resetRing.
		self redrawAllBars]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 8/5/2026 14:51'
}
SRFrameTimeGraph >> graphWidth [

	^ graphWidth
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 8/5/2026 14:52'
}
SRFrameTimeGraph >> graphWidth: aNumber [

	(aNumber isNumber and: [aNumber > 0.0]) ifFalse: [
		self error: 'graphWidth must be > 0'].
	graphWidth := aNumber asFloat.
	barWidth := graphWidth / maxFrames.
	leftEdge := graphWidth / -2.0.
	rightEdge := graphWidth / 2.0.
	self redrawAllBars
]

{
	#category : #private,
	#'squeak_changestamp' : 'lege 3/13/2026 16:49'
}
SRFrameTimeGraph >> heightForFrameTime: frameTime [

	| normalized |
	normalized := frameTime / maxFrameTimeMs.
	normalized := normalized max: 0.0.
	normalized := normalized min: 1.0.
	^ (normalized * 0.75) max: 0.001
]

{
	#category : #private,
	#'squeak_changestamp' : 'lege 3/13/2026 16:49'
}
SRFrameTimeGraph >> heightForFramesPerSecond: framesPerSecond [

	| normalized |
	normalized := framesPerSecond / maxFramesPerSecond.
	normalized := normalized max: 0.0.
	normalized := normalized min: 1.0.
	^ (normalized * 0.75) max: 0.001
]

{
	#category : #initializing,
	#'squeak_changestamp' : 'MCPServer 8/5/2026 14:51'
}
SRFrameTimeGraph >> initialize [

	super initialize.
	maxFrames := 100.
	graphWidth := 1.5.
	barDepth := 0.05.
	maxFrameTimeMs := 50.0.
	maxFramesPerSecond := 120.0.
	bucketDurationMs := 200.0.
	frameTimeBucketSize := 10.
	secondAccumulator := 0.0.
	secondFrameCount := 0.
	frameTimeBucketAccumulator := 0.0.
	frameTimeBucketCount := 0.
	mode := #frameTime.
	barWidth := graphWidth / maxFrames.
	leftEdge := graphWidth / -2.0.
	rightEdge := graphWidth / 2.0.
	self resetRing.
	self setupBars
]

{
	#category : #private,
	#'squeak_changestamp' : 'lege 3/13/2026 16:43'
}
SRFrameTimeGraph >> interpolatedColorForNormalizedSpeed: normalized [

	^ Color
		r: (1.0 - normalized)
		g: normalized
		b: 0.0
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 8/5/2026 14:51'
}
SRFrameTimeGraph >> mode [

	^ mode
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 8/5/2026 14:52'
}
SRFrameTimeGraph >> mode: aSymbol [

	((aSymbol = #frameTime) or: [aSymbol = #framesPerSecond]) ifFalse: [
		self error: 'Unknown SRFrameTimeGraph mode'].
	mode := aSymbol.
	self resetModeData.
	self redrawAllBars
]

{
	#category : #private,
	#'squeak_changestamp' : 'lege 3/13/2026 16:43'
}
SRFrameTimeGraph >> normalizedSpeedForFps: fps [

	| normalized |
	normalized := (fps - 10.0) / 80.0.
	normalized := normalized max: 0.0.
	normalized := normalized min: 1.0.
	^ normalized
]

{
	#category : #private,
	#'squeak_changestamp' : 'MCPServer 8/5/2026 14:51'
}
SRFrameTimeGraph >> recordFrameInSecond: deltaTime [

	| fpsValue |
	secondAccumulator := secondAccumulator + deltaTime.
	secondFrameCount := secondFrameCount + 1.
	[secondAccumulator >= bucketDurationMs] whileTrue: [
		fpsValue := secondFrameCount * (1000.0 / bucketDurationMs).
		self recordFramesPerSecondCount: fpsValue.
		secondAccumulator := secondAccumulator - bucketDurationMs.
		secondFrameCount := 0]
]

{
	#category : #private,
	#'squeak_changestamp' : 'MCPServer 8/5/2026 14:51'
}
SRFrameTimeGraph >> recordFrameTime: deltaTime [
	"Accumulate frames into a bucket. When the bucket is full, write the
	averaged frame time into the data ring at ringIndex and commit,
	updating the youngest bar and shifting the rest."

	| averagedFrameTime |
	frameTimeBucketAccumulator := frameTimeBucketAccumulator + deltaTime.
	frameTimeBucketCount := frameTimeBucketCount + 1.
	frameTimeBucketCount >= frameTimeBucketSize ifTrue: [
		averagedFrameTime := frameTimeBucketAccumulator / frameTimeBucketCount.
		frameTimes at: ringIndex put: averagedFrameTime.
		self commitDataPoint.
		frameTimeBucketAccumulator := 0.0.
		frameTimeBucketCount := 0]
]

{
	#category : #private,
	#'squeak_changestamp' : 'MCPServer 8/5/2026 14:51'
}
SRFrameTimeGraph >> recordFramesPerSecondCount: frameCount [
	"Write a frames-per-second sample into the data ring at ringIndex and
	commit, updating the youngest bar and shifting the rest."

	fpsCounts at: ringIndex put: frameCount.
	self commitDataPoint
]

{
	#category : #private,
	#'squeak_changestamp' : 'MCPServer 8/5/2026 15:04'
}
SRFrameTimeGraph >> redrawAllBars [
	"Recompute every bar from the current data ring. Used on configuration
	or mode changes, not on the per-frame path."

	| values |
	values := self mode = #frameTime
		ifTrue: [frameTimes]
		ifFalse: [fpsCounts].
	1 to: maxFrames do: [:index |
		| age x |
		age := (ringIndex - index) \\ maxFrames.
		x := rightEdge - (barWidth / 2.0) - (age * barWidth).
		self applyBar: index value: (values at: index) x: x]
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'MCPServer 8/5/2026 15:09'
}
SRFrameTimeGraph >> renderOn: aSRRenderer [
	"Draw all bars in one batch. Establish the graph's global transform
	once, then render each bar cube using its local-space matrix so the
	renderer composes global * local for the correct world placement."

	aSRRenderer withTransform: self globalTransform do: [
		barMatrices with: barColors do: [:matrix :color |
			aSRRenderer renderCubeTransformed: matrix withColor: color]]
]

{
	#category : #private,
	#'squeak_changestamp' : 'MCPServer 8/5/2026 14:44'
}
SRFrameTimeGraph >> resetModeData [

	self resetRing.
	secondAccumulator := 0.0.
	secondFrameCount := 0.
	frameTimeBucketAccumulator := 0.0.
	frameTimeBucketCount := 0
]

{
	#category : #private,
	#'squeak_changestamp' : 'MCPServer 8/5/2026 14:43'
}
SRFrameTimeGraph >> resetRing [
	"Initialize the data ring buffers to maxFrames zeroed slots.
	ringIndex points at the youngest element; on the first iteration
	that is the last element."

	frameTimes := OrderedCollection new: maxFrames.
	fpsCounts := OrderedCollection new: maxFrames.
	1 to: maxFrames do: [:each |
		frameTimes addLast: 0.0.
		fpsCounts addLast: 0.0].
	ringIndex := maxFrames
]

{
	#category : #private,
	#'squeak_changestamp' : 'MCPServer 8/5/2026 15:04'
}
SRFrameTimeGraph >> setupBars [
	"Initialize the per-bar local matrices and colors. Bars form a ring
	parallel to the data ring: bar at ringIndex is the youngest (rightmost),
	and each step back through the ring is one bar-width to the left."

	barWidth := graphWidth / maxFrames.
	leftEdge := graphWidth / -2.0.
	rightEdge := graphWidth / 2.0.
	barMatrices := OrderedCollection new: maxFrames.
	barColors := OrderedCollection new: maxFrames.
	1 to: maxFrames do: [:index |
		| age x |
		age := (ringIndex - index) \\ maxFrames.
		x := rightEdge - (barWidth / 2.0) - (age * barWidth).
		barMatrices addLast: (self barMatrixAtX: x height: 0.001).
		barColors addLast: Color blue]
]

{
	#category : #stepping,
	#'squeak_changestamp' : 'MCPServer 8/5/2026 14:53'
}
SRFrameTimeGraph >> step: deltaTime [

	self mode = #frameTime
		ifTrue: [self recordFrameTime: deltaTime]
		ifFalse: [self recordFrameInSecond: deltaTime]
]
