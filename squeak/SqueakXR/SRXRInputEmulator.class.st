"
Desktop input emulator for XR interactions in flat mode.
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
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 5/13/2026 13:59'
}
SRXRInputEmulator >> debugHUD [

	^ debugHUD
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 5/13/2026 13:58'
}
SRXRInputEmulator >> emulatedCamera [

	^ emulatedCamera
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'MCPServer 5/13/2026 13:58'
}
SRXRInputEmulator >> initialize [

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
	#category : #events,
	#'squeak_changestamp' : 'MCPServer 5/13/2026 13:58'
}
SRXRInputEmulator >> onWorldChanged: oldWorld [

	super onWorldChanged: oldWorld.
	self world ifNotNil: [:aWorld |
		emulatedCamera avatar: aWorld avatar]
]

{
	#category : #stepping,
	#'squeak_changestamp' : 'lege 7/20/2026 18:43'
}
SRXRInputEmulator >> step: delta [
	"Desktop debug input: TAB toggles look mode, WASD moves at 1.8m height."
	| rightHand |
	
	(Raylib isKeyPressedKey: RlKeyboardKey keyF2) ifTrue: [
		debugHUD toggleVisibility].
	
	(Raylib isKeyPressedKey: RlKeyboardKey keyF3) ifTrue: [
		self world avatar toggleOutOfBody].
	
	emulatedCamera update.
	
	(Raylib isKeyPressedKey: RlKeyboardKey keyTab) ifTrue: [
		emulatedCamera toggleLookMode].
	
	"Update left hand to follow camera at a natural offset"
	self updateLeftHandFromCamera.
	
	emulatedCamera lookModeEnabled
		ifTrue: [
			rightHand := self updateRightHandFromScreenCenter]
		ifFalse: [
			rightHand := self updateRightHandFromMouseRay].
	
	(Raylib isMouseButtonPressedButton: RlMouseButton mouseButtonLeft) ifTrue: [
		rightHand handleTrigger: 1.0].
	(Raylib isMouseButtonReleasedButton: RlMouseButton mouseButtonLeft) ifTrue: [
		rightHand handleTrigger: 0.0].
	
	((Raylib isMouseButtonPressedButton: RlMouseButton mouseButtonRight) or: [
		(Raylib isKeyDownKey: RlKeyboardKey keyZ)
		and: [Raylib isKeyDownKey: RlKeyboardKey keyLeftAlt]]) ifTrue: [
		rightHand handleSqueeze: 1.0].
	((Raylib isMouseButtonReleasedButton: RlMouseButton mouseButtonRight) or: [
		(Raylib isKeyUpKey: RlKeyboardKey keyZ)
		and: [Raylib isKeyDownKey: RlKeyboardKey keyLeftAlt]]) ifTrue: [
		rightHand handleSqueeze: 0.0].
]

{
	#category : #'hand updating',
	#'squeak_changestamp' : 'lege 7/20/2026 18:48'
}
SRXRInputEmulator >> updateLeftHandFromCamera [
	"Position the left hand at a subtle shoulder offset from the camera,
	aimed at the same point the camera is looking at (convergence at ~5m).
	Kept close (20cm) so the ray still aligns well with the camera for aiming."
	| leftHand camPos camForward camRight camDown handPos target up transform |
	leftHand := self world avatar leftHand.
	camPos := self world avatar camera globalTransform translation.
	camForward := self world avatar backward.
	camRight := self world avatar right.
	camDown := self world avatar down.
	
	"Hand position: 20cm left, 20cm down from camera"
	handPos := camPos - (camRight * 0.2) + (camDown * 0.2).
	
	"Aim at the camera's look point 5m ahead"
	target := camPos + (camForward * 5.0).
	up := self world renderer cameraUp asVector3.
	
	"Z-flip so hand's -Z = pointing direction"
	transform := (Matrix4x4 objectLookAt: target from: handPos up: up).
	leftHand globalTransform: transform.
	^ leftHand
]

{
	#category : #'hand updating',
	#'squeak_changestamp' : 'lege 7/3/2026 16:12'
}
SRXRInputEmulator >> updateRightHandFromMouseRay [
	"Position the right hand at the camera origin, aimed where the mouse points.
	Kept at camera origin so the ray exactly matches what you click on."
	| rightHand rlRay origin direction up target transform |
	rightHand := self world avatar rightHand.
	rlRay := Raylib
		getScreenToWorldRayPosition: Raylib getMousePosition
		camera: self world renderer camera.
	origin := rlRay position asVector3.
	direction := rlRay direction asVector3 normalize negated.
	up := self world renderer cameraUp asVector3.
	target := origin + direction.
	transform := (Matrix4x4 objectLookAt: target from: origin up: up).
	rightHand globalTransform: transform.
	^ rightHand
]

{
	#category : #'hand updating',
	#'squeak_changestamp' : 'lege 7/3/2026 16:10'
}
SRXRInputEmulator >> updateRightHandFromScreenCenter [
	"Position the right hand at the camera origin, aimed at screen center.
	Kept at camera origin so the ray exactly matches what you see."
	| rightHand rlRay origin direction up target transform screenCenter rlScreenCenter |
	rightHand := self world avatar rightHand.
	screenCenter := (Raylib getScreenWidth // 2) @ (Raylib getScreenHeight // 2).
	rlScreenCenter := RlVector2 new
		x: screenCenter x asFloat;
		y: screenCenter y asFloat;
		yourself.
	rlRay := Raylib
		getScreenToWorldRayPosition: rlScreenCenter
		camera: self world renderer camera.
	origin := rlRay position asVector3.
	direction := rlRay direction asVector3 normalize negated.
	up := self world renderer cameraUp asVector3.
	target := origin + direction.
	transform := (Matrix4x4 objectLookAt: target from: origin up: up).
	rightHand globalTransform: transform.
	^ rightHand
]
