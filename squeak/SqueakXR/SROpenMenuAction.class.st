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
	#'squeak_changestamp' : 'MCPServer (leo) 11/9/2026 14:26'
}
SROpenMenuAction >> run: inputState [

	inputState topButton isJustPressed ifFalse: [^ true].
	self hand avatar openMenuForHand: self hand.
	^ false
]
