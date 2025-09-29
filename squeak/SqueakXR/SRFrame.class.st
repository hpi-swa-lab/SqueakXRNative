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

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
SRFrame >> initialize [

	self isOld: false
]

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
SRFrame >> prepareFrame [

	self isOld ifFalse: [self world prepareFrame]
]

{ #category : #'as yet unclassified' }
SRFrame >> process [

	self updateActions;
		stepObjects;
		prepareFrame;
		renderObjects;
		completeFrame
]

{ #category : #'as yet unclassified' }
SRFrame >> renderObjects [

	[renderedObjects notEmpty] whileTrue: [ | currentObject |
		currentObject := renderedObjects removeFirst.
		self world render: currentObject]
]

{ #category : #'as yet unclassified' }
SRFrame >> stepObjects [

	
	| currentObject |
	[[steppedObjects notEmpty] whileTrue: [
		currentObject := steppedObjects removeFirst.
		currentObject step: deltaTime]]
		on: Error
		do: [:error |
				currentObject badStep: true.
				error pass]
]

{ #category : #'as yet unclassified' }
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
