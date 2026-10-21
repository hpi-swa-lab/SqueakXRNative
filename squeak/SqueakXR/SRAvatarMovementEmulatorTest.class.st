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
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/20/2026 15:10'
}
SRAvatarMovementEmulatorTest >> testAnAlreadyPlacedAvatarIsLeftWhereItIs [
	"The standing-back-from-the-origin default must not overrule a scene that put
	the player somewhere on purpose."

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
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/20/2026 15:10'
}
SRAvatarMovementEmulatorTest >> testFlyingMovesTheAvatarAndNotTheCamera [
	"The bug this class was carrying: WASD wrote the camera's position inside the
	rig, so the player's head drifted away from the player."

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
	#'squeak_changestamp' : 'MCPServer (jl) 10/21/2026 09:56'
}
SRAvatarMovementEmulatorTest >> testStrafingRightGoesToThePlayersRight [
	"Flying derives right from #forward cross: up and walking reads #camera
	right. The two disagreed for as long as Vector3 forward answered +z, and
	D strafed left in walk mode."

	| before fly stick |
	SRAvatar locomotionStyle == #continuous ifFalse: [^ self].
	emulator updateAvatarCamera.
	before := avatar translation.
	emulator moveStrafe: 1 advance: 0 lift: 0 deltaSeconds: 1.0.
	fly := (avatar translation - before) normalized.
	avatar locomotionEnabled: true.
	emulator moveStrafe: 1 advance: 0 lift: 0 deltaSeconds: 1.0.
	stick := (avatar stickMotionFor: avatar leftHand dt: 1.0) normalized.
	"Yaw starts at -90 degrees, looking down -z, so the player's right is +x."
	self assert: (fly dot: Vector3 right) > 0.999.
	self assert: (stick dot: Vector3 right) > 0.999.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/20/2026 15:10'
}
SRAvatarMovementEmulatorTest >> testTheHeadSitsAtEyeHeightAboveTheRig [
	"Local, so it travels with the rig. A global write would be undone as soon as
	the transform is recomputed from the local one."

	emulator updateAvatarCamera.
	self assert: (avatar camera translation y - emulator eyeHeight) abs < 0.001.
	self assert: (avatar camera globalTranslation
		- (avatar translation + (0 @ emulator eyeHeight @ 0))) length < 0.001.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (jl) 10/21/2026 09:55'
}
SRAvatarMovementEmulatorTest >> testWalkModeAsksTheStickInsteadOfMovingTheRig [
	"With locomotion on, WASD is a request like any thumbstick: the avatar's own
	walker decides what it is allowed to do with it."

	| rigBefore |
	avatar locomotionEnabled: true.
	rigBefore := avatar translation.
	emulator moveStrafe: 1 advance: 1 lift: 0 deltaSeconds: 1.0.
	self assert: 1 equals: avatar leftHand inputState joystick vector x.
	self assert: 1 equals: avatar leftHand inputState joystick vector y.
	self assert: rigBefore equals: avatar translation.
]
