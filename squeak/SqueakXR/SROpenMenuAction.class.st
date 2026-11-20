"
Opens the avatar's menu when the top button is pressed.
"
Class {
	#name : #SROpenMenuAction,
	#superclass : #SRHandAction,
	#category : #'SqueakXR-Halo',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #running,
	#'squeak_changestamp' : 'jl-MCPServer 11/20/2026 12:49'
}
SROpenMenuAction >> run: inputState [

	inputState topButton isJustPressed ifFalse: [^ true].
	self hand avatar openMenuForHand: self hand.
	^ false
]
