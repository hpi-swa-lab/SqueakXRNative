Class {
	#name : #SRHand,
	#superclass : #SRObject,
	#instVars : [
		'handIndex',
		'triggerPressed',
		'aPressed',
		'squeezePressed',
		'grabbedObject',
		'grabbedTranslationOffset',
		'grabbedDistance',
		'grabbedDistanceToAvatar'
	],
	#category : #'SqueakXR-Objects'
}

{ #category : #'as yet unclassified' }
SRHand class >> left [

	^ self new handIndex: self leftIndex
]

{ #category : #'as yet unclassified' }
SRHand class >> leftIndex [

	^ 1
]

{ #category : #'as yet unclassified' }
SRHand class >> right [

	^ self new handIndex: self rightIndex
]

{ #category : #'as yet unclassified' }
SRHand class >> rightIndex [

	^ 2
]

{ #category : #'as yet unclassified' }
SRHand >> actionsUpdated: aSRActionStates [

	| aJustPressed prevAPressed prevSqueezePressed squeezeJustPressed squeezeJustReleased threshold |
	self updateTransformFromActions: aSRActionStates;
		handleTrigger: (aSRActionStates triggers at: self handIndex).
	
	"TODO: move low handling of inputs to separate class"
	prevAPressed := aPressed.
	aPressed := aSRActionStates a.
	aJustPressed := aPressed and: prevAPressed not.
	(self isRight and: aJustPressed) ifTrue: [
		self teleport].
	
	prevSqueezePressed := squeezePressed.
	threshold := squeezePressed
		ifTrue: [0.8]
		ifFalse: [0.9].
	squeezePressed := (aSRActionStates squeeze at: self handIndex) > threshold.
	squeezeJustPressed := squeezePressed and: prevSqueezePressed not.
	squeezeJustReleased := squeezePressed not and: prevSqueezePressed.
	squeezeJustPressed ifTrue: [self startGrabbing].
	squeezeJustReleased ifTrue: [self stopGrabbing]
]

{ #category : #accessing }
SRHand >> handIndex [

	^ handIndex
]

{ #category : #accessing }
SRHand >> handIndex: anInteger [

	handIndex := anInteger.
	self name: (handIndex caseOf: {
		[self class leftIndex] -> ['Left Hand'].
		[self class rightIndex] -> ['Right Hand']})
]

{ #category : #'as yet unclassified' }
SRHand >> handleTrigger: aNumber [

	| prevTriggerPressed threshold |
	prevTriggerPressed := triggerPressed.
	threshold := triggerPressed
		ifTrue: [0.8]
		ifFalse: [0.9].
	triggerPressed := aNumber > threshold.
	
	(triggerPressed and: [prevTriggerPressed not]) 
		ifTrue: [self rayCast]
]

{ #category : #'as yet unclassified' }
SRHand >> initialize [

	super initialize.
	
	triggerPressed := false.
	aPressed := false.
	squeezePressed := false.
	
	self addChild: (SRCube new scale: 10cm asVector3);
		addChild: (SRCube new
			scale: 1cm @ 1cm @ 10m;
			translation: 0 @ 0 @ -5m).
]

{ #category : #testing }
SRHand >> isLeft [

	^ self handIndex = self class leftIndex
]

{ #category : #testing }
SRHand >> isRight [

	^ self handIndex = self class rightIndex
]

{ #category : #events }
SRHand >> onWorldChanged: oldWorld [

	super onWorldChanged: oldWorld.
	
	oldWorld ifNotNil: [oldWorld removeDependent: self].
	self world addDependent: self.
]

{ #category : #'as yet unclassified' }
SRHand >> rayCast [

	| ray results |
	ray := SRRay
		origin: self globalTranslation
		forward: (self globalTransform localDirToGlobal: Vector3 backward) normalize.
	
	results := ray cast: self world.
	
	results do: [:result |
		result object onRaycast: result.]
]

{ #category : #'as yet unclassified' }
SRHand >> startGrabbing [

	| ray |
	ray := SRRay
		origin: self globalTranslation
		forward: (self globalTransform localDirToGlobal: Vector3 backward) normalize.
	
	(ray cast: self world) ifNotEmpty: [:results | | collision |
		collision := results first.
		"TODO: should be object by default, but give option to morph to redefine grabbed morph"
		grabbedObject := collision object parent.
		grabbedDistance := self globalTranslation distanceTo: collision point.
		grabbedDistanceToAvatar := self world avatar globalTranslation distanceTo: self globalTranslation.
		grabbedTranslationOffset := grabbedObject globalTranslation - collision point]
]

{ #category : #'as yet unclassified' }
SRHand >> step: deltaTime [

	grabbedObject ifNotNil: [ | currentDistanceToAvatar avatarDistanceDelta rotation translation |
		currentDistanceToAvatar := self world avatar globalTranslation distanceTo: self globalTranslation.
		avatarDistanceDelta := currentDistanceToAvatar - grabbedDistanceToAvatar.
		translation := self globalTranslation
			+ ((self globalTransform localDirToGlobal: Vector3 backward  * (1 + (avatarDistanceDelta * 5))) * grabbedDistance)
			+ grabbedTranslationOffset.
		rotation := self globalRotation.
		grabbedObject
			globalTranslation: translation;
			globalRotation: rotation]
]

{ #category : #'as yet unclassified' }
SRHand >> stopGrabbing [

	grabbedObject := nil.
]

{ #category : #'as yet unclassified' }
SRHand >> teleport [

	| forward groundPoint t translation |
	"hand points backward, so we need to start with Vector3 backward instead of forward"
	forward := self globalTransform localDirToGlobal: Vector3 backward.
	forward y > 0 ifTrue: [^ self]. "hand is not pointing at ground"
	translation := self globalTranslation.
	t := (translation y / forward y) negated.
	groundPoint := forward * t + translation.
	self world avatar translation: groundPoint.
]

{ #category : #'as yet unclassified' }
SRHand >> update: aSymbol with: anObject [

	aSymbol = #actionsUpdated ifTrue: [self actionsUpdated: anObject]
]

{ #category : #'as yet unclassified' }
SRHand >> updateTransformFromActions: aSRActionStates [
	
	| pose |
	pose := aSRActionStates aimPoses at: self handIndex.
	self translation: pose position;
		rotation: pose orientation
]
