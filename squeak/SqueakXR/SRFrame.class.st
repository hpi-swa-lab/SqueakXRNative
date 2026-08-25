Class {
	#name : #SRFrame,
	#superclass : #Object,
	#instVars : [
		'world',
		'deltaTime',
		'steppedObjects',
		'renderedObjects',
		'isOld'
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
	#'squeak_changestamp' : 'phkeese 8/24/2026 20:44'
}
SRFrame >> completeFrame [  

	self isOld ifFalse: [self world completeFrame]
]

{
	#category : #processing,
	#'squeak_changestamp' : 'phkeese 8/24/2026 15:46'
}
SRFrame >> completePass [

	self world completePass
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
	#'squeak_changestamp' : 'phkeese 8/24/2026 20:55'
}
SRFrame >> initializeObjectLists [

	steppedObjects := self world allDescendantsSelect: #isStepping.
	renderedObjects := self world allDescendantsSelect: #isRendering.

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
	#'squeak_changestamp' : 'phkeese 8/24/2026 20:39'
}
SRFrame >> prepareFrame [ 

	self isOld ifFalse: [self world prepareFrame]
]

{
	#category : #processing,
	#'squeak_changestamp' : 'phkeese 8/24/2026 20:42'
}
SRFrame >> preparePass: aName [

	self isOld ifFalse: [self world preparePass: #opaque]
]

{
	#category : #processing,
	#'squeak_changestamp' : 'phkeese 8/24/2026 20:43'
}
SRFrame >> process [
	self
		updateActions;
		stepObjects;
		prepareFrame;
		renderPass: #opaque;
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
	#'squeak_changestamp' : 'phkeese 8/24/2026 20:53'
}
SRFrame >> renderPass: aName [
	
	self isOld ifFalse: [
		self world preparePass: aName.
		self render: (renderedObjects select: [:object | object renderLayer = aName]).
		self world completePass.
	]
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
