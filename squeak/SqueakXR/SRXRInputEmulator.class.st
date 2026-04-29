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
		'grabbedObject',
		'grabbedRelativeTransform',
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
	#'squeak_changestamp' : 'jl 4/29/2026 19:09'
}
SRXRInputEmulator >> initialize [
	"Initialize emulated camera."
	
	super initialize.
	emulatedCamera := SRXREmulatedCamera new.
	
	debugHUD := SRXRDebugHUD new emulator: self.
	self addChild: debugHUD
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MCPServer 4/28/2026 19:09'
}
SRXRInputEmulator >> onWorldChanged: aWorld [
	"Hook up our emulated camera to the renderer when added to world."
	
	super onWorldChanged: aWorld.
	
	aWorld ifNotNil: [
		(aWorld renderer respondsTo: #camera) ifTrue: [
			emulatedCamera rlCamera: aWorld renderer camera]]
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MCPServer 4/22/2026 17:38'
}
SRXRInputEmulator >> rayCast [

	self updateRightHandFromMouseRay rayCast.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MCPServer 4/28/2026 18:56'
}
SRXRInputEmulator >> startGrabbing [
	"Desktop debug: Cast a ray from right hand and grab the nearest object.
	Store the relative transformation from hand to object."
	
	| ray rightHand |
	rightHand := self world avatar rightHand.
	ray := SRRay
		origin: rightHand globalTranslation
		forward: (rightHand globalTransform localDirToGlobal: Vector3 backward) normalize.
	
	(ray castNearest: self world) ifNotNil: [:collision |
		grabbedObject := collision object parent.
		grabbedObject ifNotNil: [
			"Store the transform FROM hand TO object at grab moment"
			grabbedRelativeTransform := rightHand globalTransform inverseTransformation * grabbedObject globalTransform]]
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MCPServer 4/29/2026 12:56'
}
SRXRInputEmulator >> step: delta [
	"Desktop debug input: TAB toggles look mode, WASD moves at 1.8m height."
	| rightHand |
	
	"Ensure camera is hooked up (lazy initialization)"
	emulatedCamera rlCamera ifNil: [
		self world renderer ifNotNil: [:r |
			(r respondsTo: #camera) ifTrue: [
				emulatedCamera rlCamera: r camera]]].
	
	"Update emulated camera (WASD movement, mouse look if enabled)"
	emulatedCamera update.
	
	"TAB toggles look mode"
	(Raylib isKeyPressedKey: RlKeyboardKey keyTab) ifTrue: [
		emulatedCamera toggleLookMode].
	
	"Always update hand - either from mouse cursor or screen center"
	emulatedCamera lookModeEnabled
		ifTrue: [
			"Look mode: hand points at screen center"
			rightHand := self updateRightHandFromScreenCenter]
		ifFalse: [
			"Hand mode: hand follows mouse cursor"
			rightHand := self updateRightHandFromMouseRay].
	
	"Mouse button inputs (work in both modes)"
	(Raylib isMouseButtonPressedButton: RlMouseButton mouseButtonLeft) ifTrue: [
		rightHand handleTrigger: 1.0].
	(Raylib isMouseButtonReleasedButton: RlMouseButton mouseButtonLeft) ifTrue: [
		rightHand handleTrigger: 0.0].
	
	(Raylib isMouseButtonPressedButton: RlMouseButton mouseButtonRight) ifTrue: [
		self startGrabbing].
	(Raylib isMouseButtonReleasedButton: RlMouseButton mouseButtonRight) ifTrue: [
		self stopGrabbing].
	
	"F key for explicit raycast"
	(Raylib isKeyPressedKey: RlKeyboardKey keyF) ifTrue: [
		self rayCast].
	
	"Update grabbed object position"
	grabbedObject ifNotNil: [
		rightHand := self world avatar rightHand.
		grabbedObject globalTransform: (rightHand globalTransform * grabbedRelativeTransform)]
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MCPServer 4/28/2026 18:57'
}
SRXRInputEmulator >> stopGrabbing [
	"Desktop debug: Release the currently grabbed object."
	
	grabbedObject := nil.
	grabbedRelativeTransform := nil
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
