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
		'hasRenderingBegun',
		'isCompleted'
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

{
	#category : #processing,
	#'squeak_changestamp' : 'MCPServer (leo) 10/28/2026 18:09'
}
SRFrame >> completeFrame [

	isCompleted = true ifTrue: [^ self].
	isCompleted := true.
	self world completeFrame.
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
	#category : #processing,
	#'squeak_changestamp' : 'MCPServer (leo) 10/28/2026 18:03'
}
SRFrame >> handleError: anError [

	SRIsFrameContinuableVariable
		value: true
		during: [ToolSet handleError: anError].
	anError retry
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
	#'squeak_changestamp' : 'MCPServer (leo) 10/28/2026 17:50'
}
SRFrame >> initialize [

	self hasRenderingBegun: false.
	self isOld: false.
	isCompleted := false
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
	#'squeak_changestamp' : 'MCPServer (leo) 10/28/2026 18:03'
}
SRFrame >> prepareFrame [

	self hasRenderingBegun ifTrue: [^ self].
	self hasRenderingBegun: true.
	self world prepareFrame
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
	#'squeak_changestamp' : 'MCPServer (leo) 10/28/2026 17:50'
}
SRFrame >> renderObjects: anOrderedCollection [

	| currentObject |
	[[anOrderedCollection notEmpty] whileTrue: [
		currentObject := anOrderedCollection removeFirst.
		self world render: currentObject]]
		on: Error
		do: [:error |
			currentObject badRender: true.
			self handleError: error]
]

{
	#category : #processing,
	#'squeak_changestamp' : 'MCPServer (leo) 10/28/2026 17:50'
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
			currentObject badStep: true.
			self handleError: error]
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
