"
WASD + mouse look camera controller for flat mode.
"
Class {
	#name : #SRSimpleAvatarMovementEmulator,
	#superclass : #Object,
	#instVars : [
		'position',
		'yaw',
		'pitch',
		'moveSpeed',
		'lookSpeed',
		'lookModeEnabled',
		'avatar'
	],
	#category : #'SqueakXR-Objects',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 5/11/2026 18:18'
}
SRSimpleAvatarMovementEmulator >> avatar: anAvatar [

	avatar := anAvatar.
	self updateAvatarCamera
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 6/8/2026 10:57'
}
SRSimpleAvatarMovementEmulator >> cameraTransform [
	"Return the camera transform matrix for the current position and look direction,
	without requiring an avatar reference."
	| forward target |
	forward := self forwardVector.
	target := position + forward.
	^ Matrix4x4 objectLookAt: target from: position up: Vector3 up
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MCPServer 5/13/2026 13:57'
}
SRSimpleAvatarMovementEmulator >> forwardVector [

	| yawRad pitchRad |
	yawRad := yaw degreesToRadians.
	pitchRad := pitch degreesToRadians.
	^ (pitchRad cos * yawRad cos @ pitchRad sin @ (pitchRad cos * yawRad sin)) normalize
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MCPServer 5/13/2026 13:58'
}
SRSimpleAvatarMovementEmulator >> handleMouseDelta: aDelta [

	yaw := yaw + (aDelta x * lookSpeed).
	pitch := (pitch - (aDelta y * lookSpeed)) min: 89.0 max: -89.0
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MCPServer 5/13/2026 13:57'
}
SRSimpleAvatarMovementEmulator >> initialize [

	super initialize.
	position := -6 @ 1.8 @ 0.
	yaw := 0.0.
	pitch := 0.0.
	moveSpeed := 0.05.
	lookSpeed := 0.15.
	lookModeEnabled := false
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 5/13/2026 13:58'
}
SRSimpleAvatarMovementEmulator >> lookModeEnabled [

	^ lookModeEnabled
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 5/13/2026 13:58'
}
SRSimpleAvatarMovementEmulator >> position [

	^ position
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 6/8/2026 10:57'
}
SRSimpleAvatarMovementEmulator >> position: aVector3 [
	position := aVector3
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MCPServer 5/13/2026 13:58'
}
SRSimpleAvatarMovementEmulator >> toggleLookMode [

	lookModeEnabled := lookModeEnabled not.
	Transcript cr; show: 'Camera look mode: ',
		(lookModeEnabled ifTrue: ['ON'] ifFalse: ['OFF']).
	^ lookModeEnabled
]

{
	#category : #actions,
	#'squeak_changestamp' : 'MCPServer 6/8/2026 10:57'
}
SRSimpleAvatarMovementEmulator >> update [

	| forward right movement |
	forward := yaw degreesToRadians cos @ 0 @ yaw degreesToRadians sin.
	right := (forward cross: Vector3 up) normalize.
	movement := Vector3 zero.
	(Raylib isKeyDownKey: RlKeyboardKey keyW) ifTrue: [
		movement := movement + forward].
	(Raylib isKeyDownKey: RlKeyboardKey keyS) ifTrue: [
		movement := movement - forward].
	(Raylib isKeyDownKey: RlKeyboardKey keyD) ifTrue: [
		movement := movement + right].
	(Raylib isKeyDownKey: RlKeyboardKey keyA) ifTrue: [
		movement := movement - right].
	(Raylib isKeyDownKey: RlKeyboardKey keyLeftShift) ifTrue: [
		movement := movement + Vector3 up].
	(Raylib isKeyDownKey: RlKeyboardKey keyLeftControl) ifTrue: [
		movement := movement - Vector3 up].
	movement length > 0 ifTrue: [
		position := position + (movement normalize * moveSpeed)].
	lookModeEnabled ifTrue: [
		self handleMouseDelta: Raylib getMouseDelta].
	self updateAvatarCamera
]

{
	#category : #updating,
	#'squeak_changestamp' : 'MCPServer 5/13/2026 13:58'
}
SRSimpleAvatarMovementEmulator >> updateAvatarCamera [

	| forward |
	avatar ifNil: [^ self].
	forward := self forwardVector.
	avatar cameraPosition: position target: position + forward up: Vector3 up
]
