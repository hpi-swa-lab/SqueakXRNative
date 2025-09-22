Class {
	#name : #SRTranscriptWindow,
	#superclass : #SRObject,
	#category : #'SqueakXR-Objects'
}

{ #category : #'as yet unclassified' }
SRTranscriptWindow >> initialize [

	super initialize.
	
	self addChild: (SRMorphPanel new
		morph: (Transcript open dependents first)).
	
	Transcript addDependent: self.
]

{ #category : #'as yet unclassified' }
SRTranscriptWindow >> update: aSymbol [

	aSymbol = #appendEntry ifTrue: [
		self children first updateTexture]
]
