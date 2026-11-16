Class {
	#name : #SRXRInputEmulatorTest,
	#superclass : #TestCase,
	#category : #'SqueakXR-Tests-Objects'
}

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (jl) 11/16/2026 13:55'
}
SRXRInputEmulatorTest >> testAHeldObjectComesAlongWhenWalking [

	| emulator moved |
	emulator := SRXRInputEmulator new.
	emulator beginDrag: (Matrix4x4 withOffset: 0 @ 1 @ -2) holding: 0 @ 1 @ -2 from: 0 @ 1.8 @ 0.
	moved := emulator dragTransformTo: 0 @ 1 @ -3 from: 0 @ 1.8 @ -1.
	self assert: (moved translation - (0 @ 1 @ -3)) length < 1e-5.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (jl) 11/16/2026 13:55'
}
SRXRInputEmulatorTest >> testAHeldObjectStaysPutWhileStandingStill [

	| emulator held |
	emulator := SRXRInputEmulator new.
	emulator beginDrag: (Matrix4x4 withOffset: 0.5 @ 1 @ -2) holding: 0.5 @ 1 @ -2 from: 0 @ 1.8 @ 0.
	held := emulator dragTransformTo: 0.5 @ 1 @ -2 from: 0 @ 1.8 @ 0.
	self assert: (held translation - (0.5 @ 1 @ -2)) length < 1e-5.
]
