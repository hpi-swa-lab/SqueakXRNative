Class {
	#name : #SRXRInputEmulator,
	#superclass : #SRObject,
	#category : #'SqueakXR-Objects'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 3/25/2026 17:47'
}
SRXRInputEmulator >> rayCast [

	self world avatar rightHand
		transform: self world camera transform * (Matrix4x4 withScale: 1 @ 1 @ -1);
		rayCast.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 3/25/2026 17:47'
}
SRXRInputEmulator >> step: delta [

	(Raylib isKeyPressedKey: RlKeyboardKey keyF) ifTrue: [
		self rayCast].
]
