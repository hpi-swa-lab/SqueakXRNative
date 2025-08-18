Class {
	#name : #SRMorphProjection,
	#superclass : #SRObject,
	#instVars : [
		'morph',
		'plane',
		'texture'
	],
	#classVars : [
		'Mesh'
	],
	#category : #'SqueakXR-Core'
}

{ #category : #'as yet unclassified' }
SRMorphProjection class >> defaultPixelsPerMeter [

	^ 500
]

{ #category : #'as yet unclassified' }
SRMorphProjection >> handleRaycast: intersectionResult [

	| normalizedPoint clickPoint event point |
	point := plane globalTransform globalPointToLocal: intersectionResult point.
	normalizedPoint := point xz asPoint + 0.5 asPoint.
	clickPoint := (normalizedPoint * (self morph extent)) + self morph topLeft.
	
	[event := MouseButtonEvent new
		setType: #mouseDown
		position: clickPoint asPoint
		which: MouseButtonEvent redButton
		buttons: MouseButtonEvent redButton
		nClicks: 1
		hand: self currentHand
		stamp: Sensor eventTimeNow.
	self currentHand handleEvent: event.
	event := MouseButtonEvent new
		setType: #mouseUp
		position: clickPoint asPoint
		which: MouseButtonEvent redButton
		buttons: MouseButtonEvent redButton
		nClicks: 1
		hand: self currentHand
		stamp: Sensor eventTimeNow.
	self currentHand handleEvent: event.]
		on: ProvideAnswerNotification
		do: [:n | Transcript showln: n. n resume: true].
	
	self updateTexture
]

{ #category : #'as yet unclassified' }
SRMorphProjection >> initialize [

	super initialize.
	
	plane := SRPlane new
		addDependent: self;
		yourself.
	
	texture := SRMorphTexture new.
	
	self addChild: plane.
	
]

{ #category : #accessing }
SRMorphProjection >> morph [

	^ morph
]

{ #category : #accessing }
SRMorphProjection >> morph: aMorph [

	morph := aMorph.
	
	texture morph: morph.
	self updateTexture.
]

{ #category : #'as yet unclassified' }
SRMorphProjection >> setSizeFromPixelsPerMeter: aNumber [

	plane setScale: (self morph width / aNumber) @ 1 @ (self morph height / aNumber)
]

{ #category : #'as yet unclassified' }
SRMorphProjection >> update: aSymbol with: anObject [

	aSymbol = #raycast ifTrue: [self handleRaycast: anObject]
]

{ #category : #accessing }
SRMorphProjection >> updateTexture [

	self setSizeFromPixelsPerMeter: self class defaultPixelsPerMeter.
	plane material texture: texture update.
	
]
