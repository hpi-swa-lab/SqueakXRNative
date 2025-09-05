Class {
	#name : #SRMorphTexture,
	#superclass : #Object,
	#instVars : [
		'morph',
		'texture',
		'extent'
	],
	#category : #'SqueakXR-Core'
}

{ #category : #'as yet unclassified' }
SRMorphTexture >> createTexture [

	| form |
	form := self morph imageForm.
	self extent: form extent.
	^ texture := form createTexture
]

{ #category : #'as yet unclassified' }
SRMorphTexture >> extent [

	^ extent
]

{ #category : #'as yet unclassified' }
SRMorphTexture >> extent: aPoint [

	extent := aPoint
]

{ #category : #'as yet unclassified' }
SRMorphTexture >> morph [

	^ morph
]

{ #category : #'as yet unclassified' }
SRMorphTexture >> morph: aMorph [

	morph := aMorph
]

{ #category : #'as yet unclassified' }
SRMorphTexture >> update [

	^ (texture isNil or: [self extent ~= self morph extent])
		ifTrue: [self createTexture]
		ifFalse: [self updateTexture]
]

{ #category : #'as yet unclassified' }
SRMorphTexture >> updateTexture [

	self morph imageForm updateTexture: texture.
	^ texture
]
