Class {
	#name : #SRWorld,
	#superclass : #SRObject,
	#instVars : [
		'running',
		'renderer',
		'worldProcess',
		'needsSetup'
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
SRWorld >> doOneCycle [

	self renderer prepareFrame.
	self renderSelfAndChildrenOn: self renderer.
	self renderer completeFrame.
]

{ #category : #initializing }
SRWorld >> initialize [

	super initialize.
	
	self renderer: SRRenderer default new.
	
]

{ #category : #accessing }
SRWorld >> isRunning [

	^ running
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
			self renderer setup].
		worldProcess resume].
]

{ #category : #'as yet unclassified' }
SRWorld >> shutDown: quitting [

	needsSetup := quitting.
	self suspend.
]

{ #category : #'as yet unclassified' }
SRWorld >> start [

	self worldProcess: ([
		self renderer setup.
		running := true.
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
