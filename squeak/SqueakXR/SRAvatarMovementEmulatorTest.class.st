"
The desktop stand-in for a headset and a left controller.

Drives #moveStrafe:advance:lift:deltaSeconds: rather than #update:, so the tests need no keyboard and no renderer.
"
Class {
	#name : #SRAvatarMovementEmulatorTest,
	#superclass : #TestCase,
	#instVars : [
		'avatar',
		'emulator'
	],
	#category : #'SqueakXR-Tests-Objects',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #running,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/20/2026 15:10'
}
SRAvatarMovementEmulatorTest >> setUp [
	super setUp.
	avatar := SRAvatar new.
	SRObject new addChild: avatar.
	emulator := SRSimpleAvatarMovementEmulator new.
	emulator avatar: avatar.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 14:59'
}
SRAvatarMovementEmulatorTest >> testAnAlreadyPlacedAvatarIsLeftWhereItIs [

	| placed em |
	placed := SRAvatar new.
	SRObject new addChild: placed.
	placed translation: 7 @ 0 @ 7.
	em := SRSimpleAvatarMovementEmulator new.
	em avatar: placed.
	self assert: 7 @ 0 @ 7 equals: placed translation.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 14:59'
}
SRAvatarMovementEmulatorTest >> testFlyingMovesTheAvatarAndNotTheCamera [

	| rigBefore headInRig |
	avatar locomotionEnabled: false.
	emulator updateAvatarCamera.
	headInRig := avatar camera translation.
	rigBefore := avatar translation.
	emulator moveStrafe: 0 advance: 1 lift: 0 deltaSeconds: 1.0.
	emulator updateAvatarCamera.
	self deny: rigBefore = avatar translation.
	self assert: headInRig equals: avatar camera translation.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 14:59'
}
SRAvatarMovementEmulatorTest >> testStrafingRightGoesToThePlayersRight [

	| before fly stick |
	SRAvatar locomotionStyle == #continuous ifFalse: [^ self].
	emulator updateAvatarCamera.
	before := avatar translation.
	emulator moveStrafe: 1 advance: 0 lift: 0 deltaSeconds: 1.0.
	fly := (avatar translation - before) normalized.
	avatar locomotionEnabled: true.
	emulator moveStrafe: 1 advance: 0 lift: 0 deltaSeconds: 1.0.
	stick := (avatar stickMotionFor: avatar leftHand dt: 1.0) normalized.

	self assert: (fly dot: Vector3 right) > 0.999.
	self assert: (stick dot: Vector3 right) > 0.999.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 14:59'
}
SRAvatarMovementEmulatorTest >> testTheHeadSitsAtEyeHeightAboveTheRig [

	emulator updateAvatarCamera.
	self assert: (avatar camera translation y - emulator eyeHeight) abs < 0.001.
	self assert: (avatar camera globalTranslation
		- (avatar translation + (0 @ emulator eyeHeight @ 0))) length < 0.001.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 14:59'
}
SRAvatarMovementEmulatorTest >> testWalkModeAsksTheStickInsteadOfMovingTheRig [

	| rigBefore |
	avatar locomotionEnabled: true.
	rigBefore := avatar translation.
	emulator moveStrafe: 1 advance: 1 lift: 0 deltaSeconds: 1.0.
	self assert: 1 equals: avatar leftHand inputState joystick vector x.
	self assert: 1 equals: avatar leftHand inputState joystick vector y.
	self assert: rigBefore equals: avatar translation.
]
