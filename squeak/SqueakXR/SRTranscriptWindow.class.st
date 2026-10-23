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

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MCPServer (leo) 10/15/2026 11:10'
}
SRTranscriptWindow >> update: aSymbol [

	aSymbol = #appendEntry ifTrue: [
		self children first fullTextureUpdate].
]
