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
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 15:00'
}
SRHandInputStateTest >> testAHeldButtonIsJustPressedOnlyOnce [

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
	#'squeak_changestamp' : 'MCPServer (jl) 11/13/2026 15:45'
}
SRHandInputStateTest >> testPollingControllersClearsTheDesktopWheel [
	| state |
	state := SRHandInputState new.
	self assert: 0 equals: state wheel.
	state wheel: 2.0.
	state updateActionsRight: SRXrActionStates new.
	self assert: 0 equals: state wheel.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 15:00'
}
SRHandInputStateTest >> testReleasingIsSeenOnTheFrameItHappens [

	| state |
	state := SRHandInputState new.
	state updateDesktopTrigger: 0.0 squeeze: 1.0 topButton: false.
	self assert: state squeeze isJustPressed.
	state updateDesktopTrigger: 0.0 squeeze: 0.0 topButton: false.
	self assert: state squeeze isJustReleased.
	self deny: state squeeze isPressed.
]
