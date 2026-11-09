"
Turns the avatar in snaps with the joystick.
"
Class {
	#name : #SRSnapTurnAction,
	#superclass : #SRHandAction,
	#instVars : [
		'armed'
	],
	#category : #'SqueakXR-Halo',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #initialization,
	#'squeak_changestamp' : 'MCPServer (leo) 11/9/2026 14:56'
}
SRSnapTurnAction >> initialize [

	super initialize.
	armed := true.
]

{
	#category : #running,
	#'squeak_changestamp' : 'MCPServer (leo) 11/9/2026 15:32'
}
SRSnapTurnAction >> run: inputState [

	SRAvatar turnStyle == #smooth ifTrue: [^ true].
	self hand avatar ifNotNil: [:avatar |
		self snapTurn: avatar by: inputState joystick horizontal].
	^ true
]

{
	#category : #running,
	#'squeak_changestamp' : 'MCPServer (leo) 11/9/2026 14:56'
}
SRSnapTurnAction >> snapTurn: anAvatar by: aPush [

	aPush = 0 ifTrue: [^ armed := true].
	armed ifFalse: [^ self].
	armed := false.
	anAvatar turnBy: aPush sign * SRAvatar snapTurnAngle.
]
