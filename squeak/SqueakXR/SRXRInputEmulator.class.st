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
	#category : #'hand updating',
	#'squeak_changestamp' : 'MCPServer 5/13/2026 13:58'
}
SRXRInputEmulator >> updateRightHandFromMouseRay [

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
	#category : #'hand updating',
	#'squeak_changestamp' : 'MCPServer 5/13/2026 13:58'
}
SRXRInputEmulator >> updateRightHandFromScreenCenter [

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
	direction := rlRay direction asVector3 normalize.
	up := self world renderer cameraUp asVector3.
	target := origin + direction.
	transform := (Matrix4x4 objectLookAt: target from: origin up: up)
		* (Matrix4x4 withScale: 1 @ 1 @ -1).
	rightHand globalTransform: transform.
	^ rightHand
]
