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
	#name : #SRXREmulatedCamera,
	#superclass : #Object,
	#instVars : [
		'position',
		'yaw',
		'pitch',
		'moveSpeed',
		'lookSpeed',
		'rlCamera',
		'lookModeEnabled'
	],
	#category : #'SqueakXR-Objects',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MCPServer 4/29/2026 12:54'
}
SRXREmulatedCamera >> forwardVector [
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
	#'squeak_changestamp' : 'jl 4/28/2026 19:41'
}
SRXREmulatedCamera >> handleMouseDelta: aDelta [
	"Update yaw and pitch from mouse movement delta."
	
	yaw := yaw + (aDelta x * lookSpeed).
	pitch := pitch - (aDelta y * lookSpeed).
	
	"Clamp pitch to prevent gimbal lock"
	pitch := pitch min: 89.0 max: -89.0.
	
	self updateRaylibCamera
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'jl 4/29/2026 19:25'
}
SRXREmulatedCamera >> initialize [
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
SRXREmulatedCamera >> lookModeEnabled [
	"Return whether look mode is enabled (mouse controls camera vs hand)."
	
	^ lookModeEnabled
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MCPServer 4/29/2026 12:50'
}
SRXREmulatedCamera >> position [
	"Return current camera position."
	
	^ position
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MCPServer 4/28/2026 19:07'
}
SRXREmulatedCamera >> rlCamera [
	"Return the Raylib camera object."
	
	^ rlCamera
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MCPServer 4/28/2026 19:07'
}
SRXREmulatedCamera >> rlCamera: aRlCamera [
	"Set the Raylib camera object."
	
	rlCamera := aRlCamera.
	self updateRaylibCamera
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MCPServer 4/29/2026 12:51'
}
SRXREmulatedCamera >> toggleLookMode [
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
	#'squeak_changestamp' : 'MCPServer 4/29/2026 12:54'
}
SRXREmulatedCamera >> update [
	"Update camera: WASD moves horizontally at 1.8m height, look mode toggles mouse control."
	
	| forward right movement |
	
	"Calculate forward/right on XZ plane only (no vertical component)"
	forward := (yaw degreesToRadians cos @ 0 @ yaw degreesToRadians sin) asVector3.
	right := (forward cross: Vector3 up) normalize.
	movement := Vector3 zero.
	
	"WASD movement - only horizontal, stays at 1.8m"
	(Raylib isKeyDownKey: RlKeyboardKey keyW) ifTrue: [
		movement := movement + forward].
	(Raylib isKeyDownKey: RlKeyboardKey keyS) ifTrue: [
		movement := movement - forward].
	(Raylib isKeyDownKey: RlKeyboardKey keyD) ifTrue: [
		movement := movement + right].
	(Raylib isKeyDownKey: RlKeyboardKey keyA) ifTrue: [
		movement := movement - right].
	
	"Apply movement and lock Y to 1.8"
	movement length > 0 ifTrue: [
		position := position + (movement normalize * moveSpeed)].
	position := position x @ 1.8 @ position z.
	
	"Mouse look ONLY when in look mode"
	lookModeEnabled ifTrue: [
		self handleMouseDelta: Raylib getMouseDelta].
	
	self updateRaylibCamera
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MCPServer 4/28/2026 19:07'
}
SRXREmulatedCamera >> updateRaylibCamera [
	"Update the Raylib camera position and target from our state."
	
	| forward target |
	rlCamera ifNil: [^ self].
	
	"Calculate forward vector from yaw/pitch"
	forward := self forwardVector.
	target := position + forward.
	
	rlCamera
		position: position asRlVector;
		target: target asRlVector
]
