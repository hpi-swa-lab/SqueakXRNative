"
Aims a teleport while the joystick is pushed and teleports on release.
"
Class {
	#name : #SRTeleportAction,
	#superclass : #SRHandAction,
	#category : #'SqueakXR-Halo',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #running,
	#'squeak_changestamp' : 'MCPServer (leo) 11/9/2026 15:32'
}
SRTeleportAction >> run: inputState [

	self hand avatar ifNotNil: [:avatar |
		self updateTeleportOf: avatar with: inputState joystick vector].
	^ true
]

{
	#category : #running,
	#'squeak_changestamp' : 'MCPServer (leo) 11/9/2026 14:56'
}
SRTeleportAction >> updateTeleportOf: anAvatar with: aStick [

	SRAvatar locomotionStyle == #teleport ifFalse: [^ anAvatar cancelTeleportAim].
	(aStick x = 0 and: [aStick y = 0])
		ifTrue: [anAvatar commitTeleport]
		ifFalse: [anAvatar aimTeleportFrom: self hand].
]
