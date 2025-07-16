Class {
	#name : #SRHand,
	#superclass : #SRObject,
	#instVars : [
		'handIndex'
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

{ #category : #accessing }
SRHand >> handIndex [

	^ handIndex
]

{ #category : #accessing }
SRHand >> handIndex: anInteger [

	handIndex := anInteger
]

{ #category : #'as yet unclassified' }
SRHand >> initialize [

	super initialize.
	
	self addChild: (SRCube new scaleBy: 10cm asVector3).
]

{ #category : #events }
SRHand >> onWorldChanged: oldWorld [

	super onWorldChanged: oldWorld.
	
	oldWorld ifNotNil: [oldWorld removeDependent: self].
	self world addDependent: self.
]

{ #category : #'as yet unclassified' }
SRHand >> update: aSymbol with: anObject [

	aSymbol = #actionsUpdated ifTrue: [
		self translation: (anObject aimPoses at: self handIndex) position]
]
