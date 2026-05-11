"
Simple camera controller for desktop/flat mode emulation.
Handles WASD movement and mouse look.

Instance Variables:
  position - Vector3, camera position
  yaw - Float, horizontal rotation in degrees
  pitch - Float, vertical rotation in degrees
  moveSpeed - Float, movement speed multiplier
  lookSpeed - Float, mouse look sensitivity
  rlCamera - RlCamera3D, the actual Raylib camera object
  lookModeEnabled - Boolean, when true mouse controls camera look, when false mouse controls hand
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
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MCPServer 4/29/2026 12:54'
}
SRSimpleAvatarMovementEmulator >> forwardVector [
	"Calculate forward direction vector from yaw and pitch for camera target."
	
	| yawRad pitchRad x y z |
	yawRad := yaw degreesToRadians.
	pitchRad := pitch degreesToRadians.
	
	x := pitchRad cos * yawRad cos.
	y := pitchRad sin.
	z := pitchRad cos * yawRad sin.
	
	^ (x @ y @ z) asVector3 normalize
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MCPServer 5/11/2026 18:22'
}
SRSimpleAvatarMovementEmulator >> handleMouseDelta: aDelta [
	"Update yaw and pitch from mouse movement delta."
	
	yaw := yaw + (aDelta x * lookSpeed).
	pitch := pitch - (aDelta y * lookSpeed).
	
	pitch := pitch min: 89.0 max: -89.0
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'jl 4/29/2026 19:25'
}
SRSimpleAvatarMovementEmulator >> initialize [
	"Initialize camera at eye level, looking forward."
	
	super initialize.
	position := (-6 @ 1.8 @ 0) asVector3.
	yaw := 0.0.
	pitch := 0.0.
	moveSpeed := 0.05.
	lookSpeed := 0.15.
	lookModeEnabled := false
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MCPServer 4/29/2026 12:51'
}
SRSimpleAvatarMovementEmulator >> lookModeEnabled [
	"Return whether look mode is enabled (mouse controls camera vs hand)."
	
	^ lookModeEnabled
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MCPServer 4/29/2026 12:50'
}
SRSimpleAvatarMovementEmulator >> position [
	"Return current camera position."
	
	^ position
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MCPServer 4/29/2026 12:51'
}
SRSimpleAvatarMovementEmulator >> toggleLookMode [
	"Toggle between mouse controlling camera look vs hand position."
	
	lookModeEnabled := lookModeEnabled not.
	Transcript
		cr;
		show: 'Camera look mode: ';
		show: (lookModeEnabled ifTrue: ['ON (mouse controls camera)'] ifFalse: ['OFF (mouse controls hand)']).
	^ lookModeEnabled
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MCPServer 5/11/2026 18:09'
}
SRSimpleAvatarMovementEmulator >> update [
	"Update camera: WASD moves horizontally at 1.8m height, look mode toggles mouse control."
	
	| forward right movement |
	
	avatar ifNil: [^ self].
	
	forward := (yaw degreesToRadians cos @ 0 @ yaw degreesToRadians sin) asVector3.
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
	
	movement length > 0 ifTrue: [
		position := position + (movement normalize * moveSpeed)].
	position := position x @ 1.8 @ position z.
	
	lookModeEnabled ifTrue: [
		self handleMouseDelta: Raylib getMouseDelta].
	
	self updateAvatarCamera
]

{
	#category : #updating,
	#'squeak_changestamp' : 'MCPServer 5/11/2026 18:09'
}
SRSimpleAvatarMovementEmulator >> updateAvatarCamera [
	"Update the avatar camera position and target from our state."
	
	| forward target |
	avatar ifNil: [^ self].
	
	forward := self forwardVector.
	target := position + forward.
	
	avatar cameraPosition: position target: target up: Vector3 up
]
