Class {
	#name : #SRXRInputEmulator,
	#superclass : #SRObject,
	#category : #'SqueakXR-Objects'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MCPServer 4/22/2026 17:38'
}
SRXRInputEmulator >> rayCast [

	self updateRightHandFromMouseRay rayCast.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MCPServer 4/22/2026 17:38'
}
SRXRInputEmulator >> step: delta [
	"Desktop debug input mapping for flat mode:
	- Left mouse click => trigger press/release (right hand)
	- Right mouse press/release => start/stop grabbing (right hand)
	- Only active while free camera is OFF
	- F key => explicit ray cast"
	| rightHand freeCameraEnabled |
	
	rightHand := self updateRightHandFromMouseRay.
	
	freeCameraEnabled := (self world renderer respondsTo: #freeCameraEnabled)
		ifTrue: [self world renderer freeCameraEnabled]
		ifFalse: [true].
	
	freeCameraEnabled ifFalse: [
		(Raylib isMouseButtonPressedButton: RlMouseButton mouseButtonLeft) ifTrue: [
			rightHand handleTrigger: 1.0].
		(Raylib isMouseButtonReleasedButton: RlMouseButton mouseButtonLeft) ifTrue: [
			rightHand handleTrigger: 0.0].
		
		(Raylib isMouseButtonPressedButton: RlMouseButton mouseButtonRight) ifTrue: [
			rightHand startGrabbing].
		(Raylib isMouseButtonReleasedButton: RlMouseButton mouseButtonRight) ifTrue: [
			rightHand stopGrabbing]].
	
	(Raylib isKeyPressedKey: RlKeyboardKey keyF) ifTrue: [
		self rayCast].
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MCPServer 4/22/2026 17:38'
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
