Class {
	#name : #SRWorld,
	#superclass : #SRObject,
	#instVars : [
		'running',
		'renderer',
		'worldProcess',
		'needsSetup',
		'lastFrameTime'
	],
	#category : #'SqueakXR-Core'
}

{ #category : #'as yet unclassified' }
SRWorld class >> initialize [

	" self initialize "
	
	Smalltalk
		addToStartUpList: self;
		addToShutDownList: self.
]

{ #category : #'as yet unclassified' }
SRWorld class >> shutDown: quitting [

	self allInstances do: [:world |
		world shutDown: quitting]
]

{ #category : #'as yet unclassified' }
SRWorld class >> startUp [

	self allInstances do: [:world |
		world resume]
]

{ #category : #'as yet unclassified' }
SRWorld >> cacheAt: aSymbol ifAbsentPut: aBlock [

	^ self renderer cacheAt: aSymbol ifAbsentPut: aBlock
]

{ #category : #'as yet unclassified' }
SRWorld >> doOneCycle [

	| deltaTime startTime framePrepard |
	startTime := DateAndTime now.
	deltaTime := startTime - lastFrameTime.
	
	"Two issues with this.
	1) not resilient against errors
	2) quite inefficient because allDescendants constructs the array from scratch
	A morphic-like list approach would solve both."
	self allDescendants do: [:obj | obj step: deltaTime].
	
	framePrepard := self renderer prepareFrame.
	framePrepard ifTrue: [
		self renderSelfAndChildrenOn: self renderer.
		self renderer completeFrame].
	
	lastFrameTime := startTime.
]

{ #category : #initializing }
SRWorld >> initialize [

	super initialize.
	
	self renderer: SRRenderer rendererClass new.
	
]

{ #category : #'as yet unclassified' }
SRWorld >> invalidateCache [

	self renderer clearCache.
	self cacheInvalidated.
]

{ #category : #accessing }
SRWorld >> isRunning [

	^ running
]

{ #category : #'as yet unclassified' }
SRWorld >> isWorldObject [

	^ true
]

{ #category : #accessing }
SRWorld >> renderer [

	^ renderer
]

{ #category : #accessing }
SRWorld >> renderer: aSRRenderer [

	renderer := aSRRenderer
]

{ #category : #'as yet unclassified' }
SRWorld >> resume [

	(worldProcess notNil and: [self isRunning]) ifTrue: [
		needsSetup ifTrue: [
			needsSetup := false.
			self renderer setup.
			self allDo: #onWorldStarted.].
		worldProcess resume].
]

{ #category : #'as yet unclassified' }
SRWorld >> shutDown: quitting [

	self invalidateCache.
	needsSetup := quitting.
	self suspend.
]

{ #category : #'as yet unclassified' }
SRWorld >> start [

	self worldProcess: ([
		self renderer setup.
		self allDo: #onWorldStarted.
		running := true.
		lastFrameTime := DateAndTime now.
		[self isRunning] whileTrue: [
			self doOneCycle. Processor yield].
		self renderer shutdown
		] newProcess
			name: 'XR World Process';
			priority: Processor userSchedulingPriority).
	
	self worldProcess resume.
]

{ #category : #'as yet unclassified' }
SRWorld >> stop [

	self invalidateCache.
	running := false.
]

{ #category : #'as yet unclassified' }
SRWorld >> suspend [

	worldProcess ifNotNil: [worldProcess suspend].
]

{ #category : #accessing }
SRWorld >> worldProcess [

	^ worldProcess
]

{ #category : #accessing }
SRWorld >> worldProcess: aProcess [

	worldProcess := aProcess
]
