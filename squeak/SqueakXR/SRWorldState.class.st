Class {
	#name : #SRWorldState,
	#superclass : #WorldState,
	#category : #'SqueakXR-Morphic'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 3/11/2026 18:06'
}
SRWorldState >> drawWorld: aWorld submorphs: submorphs invalidAreasOn: aCanvas [

	| rectList validList |
	rectList := damageRecorder invalidRectsFullBoundsWithMorphs: aWorld viewBox.
	validList := super drawWorld: aWorld submorphs: submorphs invalidAreasOn: aCanvas.
	rectList keysAndValuesDo: [:rect :morphs |
		morphs do: [:morph |
			morph worldDrewIn: rect]].
	^ validList
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 2/16/2026 17:42'
}
SRWorldState >> initialize [

	super initialize.
	damageRecorder := SRDamageRecorder new.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 2/17/2026 12:59'
}
SRWorldState >> recordDamagedRect: damageRect [

	"noop, actual work happens in recordDamagedRect:from:"
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 2/16/2026 17:41'
}
SRWorldState >> recordDamagedRect: damageRect from: aMorph [

	damageRecorder recordInvalidRect: damageRect from: aMorph
]
