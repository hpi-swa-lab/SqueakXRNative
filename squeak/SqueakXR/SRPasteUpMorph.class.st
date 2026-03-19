Class {
	#name : #SRPasteUpMorph,
	#superclass : #PasteUpMorph,
	#category : #'SqueakXR-Morphic'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 3/19/2026 15:22'
}
SRPasteUpMorph >> addedMorph: aMorph [

	(aMorph shouldBeInMorphPanel and: [aMorph isInMorphPanel not]) ifTrue: [ | transform |
		"place the panel in front of the user"
		transform := XRWorld camera globalTransform
			* (Matrix4x4 withOffset: Vector3 forward * 1.25).
		XRWorld addChild: (SRMorphPanel new
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
	#'squeak_changestamp' : 'lege 3/16/2026 16:25'
}
SRPasteUpMorph >> removedMorph: aMorph [

	aMorph isInMorphPanel ifTrue: [
		XRWorld allDescendantsSelect: [:obj |
				obj isMorphPanel and: [obj morph = aMorph]]
			thenDo: [:panel |
				panel removeMorph.
				XRWorld removeChild: panel]]
]
