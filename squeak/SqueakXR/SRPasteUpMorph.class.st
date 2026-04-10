Class {
	#name : #SRPasteUpMorph,
	#superclass : #PasteUpMorph,
	#category : #'SqueakXR-Morphic'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 4/2/2026 17:14'
}
SRPasteUpMorph >> addedMorph: aMorph [

	(aMorph shouldBeInMorphPanel and: [aMorph isInMorphPanel not]) ifTrue: [ | transform |
		"place the panel in front of the user"
		transform := self currentXRWorld camera globalTransform
			* (Matrix4x4 withOffset: Vector3 forward * 1.25).
		self currentXRWorld addChild: (SRMorphPanel new
			morph: aMorph;
			transform: transform)].
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 2/16/2026 17:34'
}
SRPasteUpMorph >> beWorldForProject: aProject [

	self privateOwner: nil.
	worldState := SRWorldState new.
	self addHand: HandMorph new.
	self setProperty: #automaticPhraseExpansion toValue: true.
	self setProperty: #optimumExtentFromAuthor toValue: Display extent.
	self startSteppingSubmorphsOf: self
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 2/16/2026 17:31'
}
SRPasteUpMorph >> invalidRect: damageRect from: aMorph [

	self isWorldMorph
		ifTrue: [worldState recordDamagedRect: damageRect from: aMorph].
	^super invalidRect: damageRect from: aMorph
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 4/2/2026 17:14'
}
SRPasteUpMorph >> removedMorph: aMorph [

	aMorph isInMorphPanel ifTrue: [
		self currentXRWorld allDescendantsSelect: [:obj |
				obj isMorphPanel and: [obj morph = aMorph]]
			thenDo: [:panel |
				panel removeMorph.
				self currentXRWorld removeChild: panel]]
]
