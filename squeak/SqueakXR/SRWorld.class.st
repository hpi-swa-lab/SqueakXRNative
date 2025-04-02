Class {
	#name : #SRWorld,
	#superclass : #SRObject,
	#instVars : [
		'running',
		'renderer',
		'worldProcess'
	],
	#category : #'SqueakXR-Core'
}

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

{ #category : #nil }
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

{ #category : #accessing }
SRWorld >> worldProcess [

	^ worldProcess
]

{ #category : #accessing }
SRWorld >> worldProcess: aProcess [

	worldProcess := aProcess
]
