Class {
	#name : #SRHand,
	#superclass : #SRObject,
	#instVars : [
		'handIndex',
		'triggerPressed',
		'aPressed'
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

	| aJustPressed prevAPressed |
	self updateTransformFromActions: aSRActionStates;
		handleTrigger: (aSRActionStates triggers at: self handIndex).
	
	"TODO: move low handling of inputs to separate class"
	prevAPressed := aPressed.
	aPressed := aSRActionStates a.
	aJustPressed := aPressed and: prevAPressed not.
	(self isRight and: aJustPressed) ifTrue: [
		self teleport]
]

{ #category : #accessing }
SRHand >> handIndex [

	^ handIndex
]

{ #category : #accessing }
SRHand >> handIndex: anInteger [

	handIndex := anInteger
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
	
	self addChild: (SRCube new scaleBy: 10cm asVector3);
		addChild: (SRCube new
			setScale: 1cm @ 1cm @ 10m;
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
		forward: (self globalTransform localDirToGlobal: (0 @ 0 @ -1)) normalize.
	
	results := ray cast: self world.
	
	results do: [:result |
		result object onRaycast: result.]
]

{ #category : #'as yet unclassified' }
SRHand >> renderOn: aSRRenderer [

	"aSRRenderer renderCubeTransformed: self globalTransform * (Matrix4x4 withScale: 10cm asVector3) withColor: Color green."
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
	pose := (aSRActionStates aimPoses at: self handIndex).
	self translation: pose position;
		setRotationFromQuaternion: pose orientation
]
