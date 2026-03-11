Class {
	#name : #SRMorphPanelTest,
	#superclass : #TestCase,
	#category : #'SqueakXR-Tests-Morphic'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 2/17/2026 18:45'
}
SRMorphPanelTest >> testMorphInPanel [

	| morph panel |
	morph := Morph new.
	panel := SRDummyMorphPanel new.
	
	self deny: morph isInMorphPanel.
	panel morph: morph.
	self assert: morph isInMorphPanel.
]
