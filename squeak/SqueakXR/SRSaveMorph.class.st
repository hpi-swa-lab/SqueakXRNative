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

	| directory newImageName newChangesName |
	directory := FileDirectory forFileName: Smalltalk imageName.
	newImageName := (directory  / 'local.image') fullName.
	newChangesName := (directory / 'local.changes') fullName.
	
	directory
		copyFile: (FileStream fileNamed: Smalltalk changesName)
		toFile: (FileStream forceNewFileNamed: newChangesName).
	
	Smalltalk changeImageNameTo: newImageName.
	Smalltalk snapshot: true andQuit: false
]
