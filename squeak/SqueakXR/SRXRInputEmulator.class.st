"
Desktop input emulator for testing XR interactions in flat mode.
Maps mouse and keyboard to simulated VR controller actions and camera control.

Instance Variables:
  grabbedObject - Currently grabbed SRObject or nil (desktop debug only)
  grabbedRelativeTransform - Matrix4x4 storing hand-to-object transform when grab started
  emulatedCamera - SRXREmulatedCamera for desktop camera control (WASD + mouse look)
"
Class {
	#name : #SRXRInputEmulator,
	#superclass : #SRObject,
	#instVars : [
		'emulatedCamera',
		'debugHUD'
	],
	#category : #'SqueakXR-Objects',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MCPServer 4/29/2026 14:53'
}
SRXRInputEmulator >> debugHUD [
	"Return the debug HUD."
	
	^ debugHUD
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MCPServer 4/28/2026 19:08'
}
SRXRInputEmulator >> emulatedCamera [
	"Return the emulated camera."
	
	^ emulatedCamera
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MCPServer 5/11/2026 18:26'
}
SRXRInputEmulator >> initialize [
	"Initialize emulated camera."
	
	super initialize.
	emulatedCamera := SRSimpleAvatarMovementEmulator new.
	
	debugHUD := SRXRDebugHUD new.
	self addChild: debugHUD
]

{
	#category : #testing,
	#'squeak_changestamp' : 'MCPServer 5/11/2026 17:40'
}
SRXRInputEmulator >> isXRInputEmulator [

	^ true
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MCPServer 5/11/2026 18:21'
}
SRXRInputEmulator >> onWorldChanged: oldWorld [
	"Hook up our emulated camera to the avatar when added to world."
	
	super onWorldChanged: oldWorld.
	
	self world ifNotNil: [:aWorld |
		emulatedCamera avatar: aWorld avatar]
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MCPServer 4/22/2026 17:38'
}
SRXRInputEmulator >> rayCast [

	self updateRightHandFromMouseRay rayCast.
]

{
	#category : #stepping,
	#'squeak_changestamp' : 'MCPServer 5/13/2026 13:25'
}
SRXRInputEmulator >> step: delta [
	"Desktop debug input: TAB toggles look mode, WASD moves at 1.8m height."
	| rightHand |
	
	emulatedCamera update.
	
	(Raylib isKeyPressedKey: RlKeyboardKey keyTab) ifTrue: [
		emulatedCamera toggleLookMode].
	
	(Raylib isKeyPressedKey: RlKeyboardKey keyF2) ifTrue: [
		debugHUD toggleVisibility].
	
	emulatedCamera lookModeEnabled
		ifTrue: [
			rightHand := self updateRightHandFromScreenCenter]
		ifFalse: [
			rightHand := self updateRightHandFromMouseRay].
	
	(Raylib isMouseButtonPressedButton: RlMouseButton mouseButtonLeft) ifTrue: [
		rightHand handleTrigger: 1.0].
	(Raylib isMouseButtonReleasedButton: RlMouseButton mouseButtonLeft) ifTrue: [
		rightHand handleTrigger: 0.0].
	
	(Raylib isMouseButtonPressedButton: RlMouseButton mouseButtonRight) ifTrue: [
		rightHand handleSqueeze: 1.0].
	(Raylib isMouseButtonReleasedButton: RlMouseButton mouseButtonRight) ifTrue: [
		rightHand handleSqueeze: 0.0].
	
	(Raylib isKeyPressedKey: RlKeyboardKey keyF) ifTrue: [
		self rayCast]
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MCPServer 4/29/2026 09:30'
}
SRXRInputEmulator >> updateRightHandFromMouseRay [
	"Align right hand with a ray through current mouse cursor position."
	| rightHand rlRay origin direction up target transform |
	
	rightHand := self world avatar rightHand.
	rlRay := Raylib
		getScreenToWorldRayPosition: Raylib getMousePosition
		camera: self world renderer camera.
	origin := rlRay position asVector3.
	direction := rlRay direction asVector3 normalize.
	up := self world renderer cameraUp asVector3.
	target := origin + direction.
	transform := (Matrix4x4 objectLookAt: target from: origin up: up)
		* (Matrix4x4 withScale: 1 @ 1 @ -1).
	rightHand globalTransform: transform.
	^ rightHand
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MCPServer 4/29/2026 12:57'
}
SRXRInputEmulator >> updateRightHandFromScreenCenter [
	"Align right hand with a ray through screen center (for look mode)."
	| rightHand rlRay origin direction up target transform screenCenter rlScreenCenter |
	
	rightHand := self world avatar rightHand.
	
	"Use screen center for FPS-style pointing"
	screenCenter := (Raylib getScreenWidth // 2) @ (Raylib getScreenHeight // 2).
	rlScreenCenter := RlVector2 new
		x: screenCenter x asFloat;
		y: screenCenter y asFloat;
		yourself.
	rlRay := Raylib
		getScreenToWorldRayPosition: rlScreenCenter
		camera: self world renderer camera.
	origin := rlRay position asVector3.
	direction := rlRay direction asVector3 normalize.
	up := self world renderer cameraUp asVector3.
	target := origin + direction.
	transform := (Matrix4x4 objectLookAt: target from: origin up: up)
		* (Matrix4x4 withScale: 1 @ 1 @ -1).
	rightHand globalTransform: transform.
	^ rightHand
]
