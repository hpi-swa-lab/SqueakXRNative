Class {
	#name : #SRFrame,
	#superclass : #Object,
	#instVars : [
		'world',
		'deltaTime',
		'steppedObjects',
		'isOld',
		'overlayObjects',
		'opaqueObjects'
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
	#'squeak_changestamp' : 'phkeese 8/24/2026 13:49'
}
SRFrame >> initializeObjectLists [

	| allRenderedObjects |
	steppedObjects := self world allDescendantsSelect: #isStepping.
	allRenderedObjects := self world allDescendantsSelect: #isRendering.
	opaqueObjects := allRenderedObjects select: [:object | object renderLayer = #opaque].	
	overlayObjects := allRenderedObjects select: [:object | object renderLayer = #overlay].
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
	#'squeak_changestamp' : 'lege 4/1/2026 17:00'
}
SRFrame >> process [

	self updateActions;
		stepObjects;
		prepareFrame;
		renderObjects;
		completeFrame
]

{
	#category : #processing,
	#'squeak_changestamp' : 'phkeese 8/24/2026 13:40'
}
SRFrame >> render: anObjectList [
	| currentObject |
	[[anObjectList notEmpty] whileTrue: [
		currentObject := anObjectList removeFirst.
		self world render: currentObject]]
		on: Error
		do: [:error |
			"ToolSet default handleError: error."
			error printVerboseOn: Transcript.
			currentObject badRender: true.
			error retry.]

]

{
	#category : #processing,
	#'squeak_changestamp' : 'phkeese 8/24/2026 13:31'
}
SRFrame >> renderObjects [

	self render: opaqueObjects.
	self render: overlayObjects.
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
