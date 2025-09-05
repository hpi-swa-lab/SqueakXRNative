Class {
	#name : #SRSaveMorph,
	#superclass : #Morph,
	#category : #'SqueakXR-Core'
}

{ #category : #'as yet unclassified' }
SRSaveMorph >> initialize [

	| button |
	super initialize.
	
	button := (SimpleButtonMorph new
		label: 'Save image'
		font: (StrikeFont familyName: #DefaultTextStyle size: 20))
		extent: 200 @ 100;
		target: self;
		actionSelector: #save.
	self addMorph: button;
		extent: button extent.
]

{ #category : #'as yet unclassified' }
SRSaveMorph >> save [

	Smalltalk snapshot: true andQuit: false
]
