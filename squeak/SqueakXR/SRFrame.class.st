Class {
	#name : #SRFrame,
	#superclass : #Object,
	#instVars : [
		'world',
		'deltaTime',
		'steppedObjects',
		'isOld',
		'firstPassRenderedObjects',
		'secondPassRenderedObjects'
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

{ #category : #initializing }
SRFrame >> initialize [

	self isOld: false
]

{
	#category : #initializing,
	#'squeak_changestamp' : 'MCPServer 9/25/2026 11:53'
}
SRFrame >> initializeObjectLists [
	"One traversal, three world-owned buffers. The two allDescendantsSelect: passes
	this replaces walked the tree twice and built three collections per frame, and
	allDescendantsSelect:thenDo: built a fourth internally."

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

{ #category : #processing }
SRFrame >> prepareFrame [

	self isOld ifFalse: [self world prepareFrame]
]

{
	#category : #processing,
	#'squeak_changestamp' : 'jl 9/21/2026 17:31'
}
SRFrame >> process [

	self updateActions;
		stepObjects;
		prepareFrame;
		renderObjects;
		completeFrame.
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
