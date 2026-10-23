Class {
	#name : #SRFrame,
	#superclass : #Object,
	#instVars : [
		'world',
		'deltaTime',
		'steppedObjects',
		'isOld',
		'firstPassRenderedObjects',
		'secondPassRenderedObjects',
		'hasRenderingBegun'
	],
	#category : #'SqueakXR-Core'
}

{ #category : #'as yet unclassified' }
SRFrame class >> world: world deltaTime: deltaTime [

	^ self new
		world: world;
		deltaTime: deltaTime;
		initializeObjectLists
]

{ #category : #processing }
SRFrame >> completeFrame [

	self world completeFrame
]

{ #category : #accessing }
SRFrame >> deltaTime [

	^ deltaTime
]

{ #category : #accessing }
SRFrame >> deltaTime: aNumber [

	deltaTime := aNumber
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'leo 9/30/2026 16:09'
}
SRFrame >> hasRenderingBegun [

	^ hasRenderingBegun
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'leo 9/30/2026 16:09'
}
SRFrame >> hasRenderingBegun: aBoolean [

	hasRenderingBegun := aBoolean
]

{
	#category : #initializing,
	#'squeak_changestamp' : 'leo 9/30/2026 16:09'
}
SRFrame >> initialize [

	self hasRenderingBegun: false.
	self isOld: false
]

{
	#category : #initializing,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 15:00'
}
SRFrame >> initializeObjectLists [

	steppedObjects := self world steppedObjectsBuffer reset.
	firstPassRenderedObjects := self world firstPassRenderBuffer reset.
	secondPassRenderedObjects := self world secondPassRenderBuffer reset.
	self world allDo: [:object |
		object isStepping ifTrue: [steppedObjects add: object].
		object isRendering ifTrue: [
			(object renderInSecondPass
				ifTrue: [secondPassRenderedObjects]
				ifFalse: [firstPassRenderedObjects]) add: object]].
]

{ #category : #accessing }
SRFrame >> isOld [

	^ isOld
]

{ #category : #accessing }
SRFrame >> isOld: aBoolean [

	isOld := aBoolean
]

{
	#category : #processing,
	#'squeak_changestamp' : 'leo 9/30/2026 16:09'
}
SRFrame >> prepareFrame [

	self hasRenderingBegun: true.
	self isOld ifFalse: [self world prepareFrame]
]

{
	#category : #processing,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 15:01'
}
SRFrame >> process [
	"A frame that opened must close, or the OpenXR session is left open for every frame after 
	it."
	self updateActions; stepObjects.
	[self prepareFrame; renderObjects] ensure: [self completeFrame].

]

{
	#category : #processing,
	#'squeak_changestamp' : 'leo 9/8/2026 18:22'
}
SRFrame >> renderObjects [

	self renderObjects: firstPassRenderedObjects;
		renderObjects: secondPassRenderedObjects.
]

{
	#category : #processing,
	#'squeak_changestamp' : 'leo 9/8/2026 18:21'
}
SRFrame >> renderObjects: anOrderedCollection [

	| currentObject |
	[[anOrderedCollection notEmpty] whileTrue: [
		currentObject := anOrderedCollection removeFirst.
		self world render: currentObject]]
		on: Error
		do: [:error |
			"ToolSet default handleError: error."
			error printVerboseOn: Transcript.
			currentObject badRender: true.
			error retry.].
]

{
	#category : #processing,
	#'squeak_changestamp' : 'lege 7/16/2026 10:08'
}
SRFrame >> stepObjects [

	
	| currentObject |
	[[steppedObjects notEmpty] whileTrue: [
		currentObject := steppedObjects removeFirst.
		"It's possible that the current object was removed in another step: call in this frame.
		Thus, we need to check if the object is still in the world before proceeding."
		currentObject world = self world ifTrue: [
			currentObject step: deltaTime]]]
		on: Error
		do: [:error |
				"ToolSet default handleError: error."
				error printVerboseOn: Transcript.
				currentObject badStep: true.
				error retry.]
]

{ #category : #processing }
SRFrame >> updateActions [

	isOld ifFalse: [self world updateActions]
]

{ #category : #accessing }
SRFrame >> world [

	^ world
]

{ #category : #accessing }
SRFrame >> world: aSRWorld [

	world := aSRWorld
]
