Class {
	#name : #SRHand,
	#superclass : #SRObject,
	#instVars : [
		'handIndex',
		'triggerPressed'
	],
	#category : #'SqueakXR-Core'
}

{ #category : #'as yet unclassified' }
SRHand class >> left [

	^ self new handIndex: 1
]

{ #category : #'as yet unclassified' }
SRHand class >> right [

	^ self new handIndex: 2
]

{ #category : #'as yet unclassified' }
SRHand >> actionsUpdated: aSRActionStates [

	self updateTransformFromActions: aSRActionStates;
		handleTrigger: (aSRActionStates triggers at: self handIndex).
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
	
	self addChild: (SRCube new scaleBy: 10cm asVector3).
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
	Transcript showln: '=============================';
		showln: results size.
	
	results do: [:result | | cube |
		cube := SRCube new
			setScale: 5cm asVector3;
			translation: result point.
		self world addChild: cube.]
]

{ #category : #'as yet unclassified' }
SRHand >> renderOn: aSRRenderer [

	"aSRRenderer renderCubeTransformed: self globalTransform * (Matrix4x4 withScale: 10cm asVector3) withColor: Color green."
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
