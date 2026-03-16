Class {
	#name : #SRFrameTimeGraph,
	#superclass : #SRObject,
	#instVars : [
		'bars',
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
		'frameTimeBucketCount'
	],
	#category : #'SqueakXR-Objects'
}

{
	#category : #private,
	#'squeak_changestamp' : 'lege 3/13/2026 16:46'
}
SRFrameTimeGraph >> averagedFrameTimeForBucketIndex: index [

	| start sum count |
	start := ((index - 1) * frameTimeBucketSize) + 1.
	sum := 0.0.
	count := 0.
	start to: (start + frameTimeBucketSize - 1) do: [:sampleIndex |
		frameTimes at: sampleIndex ifPresent: [:value |
			sum := sum + value.
			count := count + 1]].
	count = 0 ifTrue: [^ 0.0].
	^ sum / count
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 3/13/2026 16:38'
}
SRFrameTimeGraph >> bucketDurationMs [

	self ensureConfiguration.
	^ bucketDurationMs
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 3/13/2026 16:38'
}
SRFrameTimeGraph >> bucketDurationMs: milliseconds [

	self ensureConfiguration.
	(milliseconds isNumber and: [milliseconds > 0.0]) ifFalse: [
		self error: 'bucketDurationMs must be > 0'].
	bucketDurationMs := milliseconds asFloat.
	secondAccumulator := 0.0.
	secondFrameCount := 0.
	self mode = #framesPerSecond ifTrue: [
		fpsCounts removeAll.
		self updateBars]
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
	#'squeak_changestamp' : 'lege 3/13/2026 17:44'
}
SRFrameTimeGraph >> ensureConfiguration [

	maxFrames ifNil: [maxFrames := 100].
	graphWidth ifNil: [graphWidth := 1.5].
	barDepth ifNil: [barDepth := 0.05].
	maxFrameTimeMs ifNil: [maxFrameTimeMs := 50.0].
	maxFramesPerSecond ifNil: [maxFramesPerSecond := 120.0].
	bucketDurationMs ifNil: [bucketDurationMs := 200.0].
	frameTimeBucketSize ifNil: [frameTimeBucketSize := 10].
	frameTimes ifNil: [frameTimes := OrderedCollection new: maxFrames].
	fpsCounts ifNil: [fpsCounts := OrderedCollection new: maxFrames].
	bars ifNil: [
		bars := OrderedCollection new: maxFrames.
		self setupBars].
	secondAccumulator ifNil: [secondAccumulator := 0.0].
	secondFrameCount ifNil: [secondFrameCount := 0].
	frameTimeBucketAccumulator ifNil: [frameTimeBucketAccumulator := 0.0].
	frameTimeBucketCount ifNil: [frameTimeBucketCount := 0].
	mode ifNil: [mode := #frameTime]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 3/13/2026 16:46'
}
SRFrameTimeGraph >> frameTimeBucketSize [

	self ensureConfiguration.
	^ frameTimeBucketSize
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 3/13/2026 17:44'
}
SRFrameTimeGraph >> frameTimeBucketSize: frameCount [

	self ensureConfiguration.
	(frameCount isNumber and: [frameCount > 0]) ifFalse: [
		self error: 'frameTimeBucketSize must be > 0'].
	frameTimeBucketSize := frameCount asInteger max: 1.
	frameTimes removeAll.
	frameTimeBucketAccumulator := 0.0.
	frameTimeBucketCount := 0.
	self mode = #frameTime ifTrue: [self updateBars]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 3/13/2026 16:49'
}
SRFrameTimeGraph >> graphWidth [

	self ensureConfiguration.
	^ graphWidth
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 3/13/2026 16:49'
}
SRFrameTimeGraph >> graphWidth: aNumber [

	self ensureConfiguration.
	(aNumber isNumber and: [aNumber > 0.0]) ifFalse: [
		self error: 'graphWidth must be > 0'].
	graphWidth := aNumber asFloat.
	self updateBars
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
	#'squeak_changestamp' : 'lege 3/13/2026 17:44'
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
	frameTimes := OrderedCollection new: maxFrames.
	fpsCounts := OrderedCollection new: maxFrames.
	bars := OrderedCollection new: maxFrames.
	secondAccumulator := 0.0.
	secondFrameCount := 0.
	frameTimeBucketAccumulator := 0.0.
	frameTimeBucketCount := 0.
	mode := #frameTime.
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
	#'squeak_changestamp' : 'lege 3/13/2026 16:31'
}
SRFrameTimeGraph >> mode [

	self ensureConfiguration.
	^ mode
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 3/13/2026 16:31'
}
SRFrameTimeGraph >> mode: aSymbol [

	self ensureConfiguration.
	((aSymbol = #frameTime) or: [aSymbol = #framesPerSecond]) ifFalse: [
		self error: 'Unknown SRFrameTimeGraph mode'].
	mode := aSymbol.
	self resetModeData.
	self updateBars
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
	#'squeak_changestamp' : 'lege 3/13/2026 16:38'
}
SRFrameTimeGraph >> recordFrameInSecond: deltaTime [

	| fpsValue |
	self ensureConfiguration.
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
	#'squeak_changestamp' : 'lege 3/13/2026 17:44'
}
SRFrameTimeGraph >> recordFrameTime: deltaTime [

	| averagedFrameTime |
	self ensureConfiguration.
	frameTimeBucketAccumulator := frameTimeBucketAccumulator + deltaTime.
	frameTimeBucketCount := frameTimeBucketCount + 1.
	frameTimeBucketCount >= frameTimeBucketSize ifTrue: [
		averagedFrameTime := frameTimeBucketAccumulator / frameTimeBucketCount.
		frameTimes addFirst: averagedFrameTime.
		frameTimes size > maxFrames ifTrue: [
			frameTimes removeLast].
		frameTimeBucketAccumulator := 0.0.
		frameTimeBucketCount := 0]
]

{
	#category : #private,
	#'squeak_changestamp' : 'lege 3/13/2026 16:30'
}
SRFrameTimeGraph >> recordFramesPerSecondCount: frameCount [

	fpsCounts ifNil: [fpsCounts := OrderedCollection new: maxFrames].
	fpsCounts addFirst: frameCount.
	fpsCounts size > maxFrames ifTrue: [
		fpsCounts removeLast]
]

{
	#category : #private,
	#'squeak_changestamp' : 'lege 3/13/2026 17:44'
}
SRFrameTimeGraph >> resetModeData [

	frameTimes ifNil: [frameTimes := OrderedCollection new: maxFrames] ifNotNil: [frameTimes removeAll].
	fpsCounts ifNil: [fpsCounts := OrderedCollection new: maxFrames] ifNotNil: [fpsCounts removeAll].
	secondAccumulator := 0.0.
	secondFrameCount := 0.
	frameTimeBucketAccumulator := 0.0.
	frameTimeBucketCount := 0
]

{
	#category : #private,
	#'squeak_changestamp' : 'lege 3/13/2026 16:39'
}
SRFrameTimeGraph >> setupBars [

	| barWidth leftEdge |
	barWidth := graphWidth / maxFrames.
	leftEdge := graphWidth / -2.0.
	1 to: maxFrames do: [:index |
		| bar x |
		bar := SRCube new.
		x := leftEdge + ((maxFrames - index) * barWidth) + (barWidth / 2.0).
		bar
			name: 'FrameBar', index asString;
			color: Color blue;
			scale: barWidth @ 0.001 @ barDepth;
			translation: x @ 0.0005 @ 0.
		self addChild: bar.
		bars add: bar]
]

{
	#category : #stepping,
	#'squeak_changestamp' : 'lege 3/13/2026 16:31'
}
SRFrameTimeGraph >> step: deltaTime [

	self ensureConfiguration.
	self updateModeDataWith: deltaTime.
	self updateBars
]

{
	#category : #private,
	#'squeak_changestamp' : 'lege 3/13/2026 16:46'
}
SRFrameTimeGraph >> trimFrameTimeHistory [

	| maxStored |
	maxStored := maxFrames * frameTimeBucketSize.
	[frameTimes size > maxStored] whileTrue: [
		frameTimes removeLast]
]

{
	#category : #private,
	#'squeak_changestamp' : 'lege 3/13/2026 16:43'
}
SRFrameTimeGraph >> updateBars [

	| barWidth leftEdge |
	self ensureConfiguration.
	barWidth := graphWidth / maxFrames.
	leftEdge := graphWidth / -2.0.
	1 to: maxFrames do: [:index |
		| value height x bar color |
		value := self valueAt: index.
		height := self mode = #frameTime
			ifTrue: [self heightForFrameTime: value]
			ifFalse: [self heightForFramesPerSecond: value].
		color := self mode = #frameTime
			ifTrue: [self colorForFrameTime: value]
			ifFalse: [self colorForFramesPerSecond: value].
		x := leftEdge + ((maxFrames - index) * barWidth) + (barWidth / 2.0).
		bar := bars at: index.
		bar
			color: color;
			scale: barWidth @ height @ barDepth;
			translation: x @ (height / 2.0) @ 0.]
]

{
	#category : #private,
	#'squeak_changestamp' : 'lege 3/13/2026 16:30'
}
SRFrameTimeGraph >> updateModeDataWith: deltaTime [

	self mode = #frameTime
		ifTrue: [self recordFrameTime: deltaTime]
		ifFalse: [self recordFrameInSecond: deltaTime]
]

{
	#category : #private,
	#'squeak_changestamp' : 'lege 3/13/2026 17:44'
}
SRFrameTimeGraph >> valueAt: index [

	self mode = #frameTime
		ifTrue: [^ frameTimes at: index ifAbsent: [0.0]]
		ifFalse: [^ fpsCounts at: index ifAbsent: [0.0]]
]
