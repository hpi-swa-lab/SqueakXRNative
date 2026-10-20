"
The desktop feeds this the same six fields the OpenXR action states do, which is what lets flat mode and XR share #performActions.
"
Class {
	#name : #SRHandInputStateTest,
	#superclass : #TestCase,
	#category : #'SqueakXR-Tests-Objects',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/20/2026 15:16'
}
SRHandInputStateTest >> testAHeldButtonIsJustPressedOnlyOnce [
	"Holding the mouse down must not fire the trigger every frame."

	| state |
	state := SRHandInputState new.
	state updateDesktopTrigger: 1.0 squeeze: 0.0 topButton: true.
	self assert: state trigger isJustPressed.
	self assert: state topButton isJustPressed.
	state updateDesktopTrigger: 1.0 squeeze: 0.0 topButton: true.
	self deny: state trigger isJustPressed.
	self deny: state topButton isJustPressed.
	self assert: state trigger isPressed.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/20/2026 15:16'
}
SRHandInputStateTest >> testReleasingIsSeenOnTheFrameItHappens [
	"The desktop reports a level every frame rather than edges, so letting go is
	a frame that reports zero."

	| state |
	state := SRHandInputState new.
	state updateDesktopTrigger: 0.0 squeeze: 1.0 topButton: false.
	self assert: state squeeze isJustPressed.
	state updateDesktopTrigger: 0.0 squeeze: 0.0 topButton: false.
	self assert: state squeeze isJustReleased.
	self deny: state squeeze isPressed.
]
