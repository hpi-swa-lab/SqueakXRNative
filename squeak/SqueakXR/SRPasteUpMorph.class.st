Class {
	#name : #SRPasteUpMorph,
	#superclass : #PasteUpMorph,
	#category : #'SqueakXR-Morphic'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 7/29/2026 17:57'
}
SRPasteUpMorph >> addedMorph: aMorph [

	| camera |
	(SRIsAddingMorphsToWorldVariable value
		and: [aMorph shouldBeInMorphPanel]
		and: [aMorph isInMorphPanel not]) ifTrue: [ | transform |
		"place the panel in front of the user"
		camera := self currentXRWorld camera.
		transform := Matrix4x4
			objectLookAt: camera globalTranslation
			from: camera globalTranslation + (camera forward * 1.25)
			up: Vector3 up.
		self currentXRWorld addChild: (
			SRMorphPanel new
				morph: aMorph;
				globalTransform: transform)].
]

{
	#category : #'dropping/grabbing',
	#'squeak_changestamp' : 'MCPServer 8/10/2026 13:55'
}
SRPasteUpMorph >> allowsMorphGrabbing [
	^false
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
	#category : #'dropping/grabbing',
	#'squeak_changestamp' : 'MCPServer 8/10/2026 13:55'
}
SRPasteUpMorph >> morphToGrab: event [
	^ self allowsMorphGrabbing
		ifTrue: [super morphToGrab: event]
		ifFalse: [nil]
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
