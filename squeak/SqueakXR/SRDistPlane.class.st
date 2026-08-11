Class {
	#name : #SRDistPlane,
	#superclass : #SRPlane,
	#category : #'SqueakXR-Objects'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 8/11/2026 14:38'
}
SRDistPlane >> step: delta [
	| hand dist |
	hand := self world avatar rightHand.
	dist := self collisionGeometry distanceTo: hand globalTranslation.
	"Transcript showln: dist."
]
