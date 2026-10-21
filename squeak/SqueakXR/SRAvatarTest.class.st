"
Tests for the player rig. An SRAvatar builds its own hands and camera, so locomotion can be exercised without an SRWorld -- which matters, because the only live world belongs to the person wearing the headset.
"
Class {
	#name : #SRAvatarTest,
	#superclass : #TestCase,
	#instVars : [
		'savedLocomotionStyle',
		'savedWalkSpeed'
	],
	#category : #'SqueakXR-Tests-Objects',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #building,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/20/2026 13:44'
}
SRAvatarTest >> avatarOnFloorAtY: aHeight [
	"An avatar standing in a scene with a floor, which is all the locomotion servo
	needs: no SRWorld, because the only live one belongs to whoever is wearing the
	headset."

	| scene avatar |
	scene := SRObject new.
	scene addChild: (SRPlane new
		scale: 40 @ 1 @ 40;
		translation: 0 @ aHeight @ 0;
		solid: true;
		yourself).
	avatar := SRAvatar new.
	scene addChild: avatar.
	avatar
		locomotionEnabled: true;
		translation: 0 @ aHeight @ 0.
	^ avatar
]

{
	#category : #running,
	#'squeak_changestamp' : 'MCPServer (jl) 10/21/2026 11:30'
}
SRAvatarTest >> setUp [
	"The class variable, not the resolved value: writing back a number pins a
	literal where nil is the documented 'use the code default'."

	super setUp.
	savedLocomotionStyle := SRAvatar classPool at: #ContinuousLocomotion ifAbsent: [nil].
	savedWalkSpeed := SRAvatar classPool at: #WalkSpeed ifAbsent: [nil].
	SRAvatar classPool at: #ContinuousLocomotion put: nil.
	SRAvatar classPool at: #WalkSpeed put: nil.
]

{
	#category : #running,
	#'squeak_changestamp' : 'MCPServer (jl) 10/21/2026 11:30'
}
SRAvatarTest >> tearDown [
	"Restored even when a test fails, so running the tests can never retune the
	live world."

	SRAvatar classPool at: #ContinuousLocomotion put: savedLocomotionStyle.
	SRAvatar classPool at: #WalkSpeed put: savedWalkSpeed.
	super tearDown.
]

{
	#category : #'tests - locomotion',
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/19/2026 14:52'
}
SRAvatarTest >> testDuckingDoesNotMoveTheRig [
	"The floor is the rig origin, because OpenXR tracks in STAGE space. Deriving the
	feet from the head by subtracting a fixed body height made the ground rise and
	fall with the player's head."

	| avatar |
	avatar := self avatarOnFloorAtY: 0.
	avatar snapBodyUnderHead: 0 @ 1.8 @ 0 floorY: 0.
	#(1.8 1.3 0.9 1.8) do: [:eye |
		| correction |
		correction := avatar
			walkCorrectionForHead: 0 @ eye @ 0
			floorY: 0
			stickMotion: nil
			dt: 0.05.
		self assert: correction y abs < 0.01].
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (jl) 10/21/2026 11:48'
}
SRAvatarTest >> testGhostEyesAndRaysBothPointForward [
	"The eyes were authored on +z and the hand rays on -z, so they disagreed by
	a half turn and only looked right while SRAvatarCamera negated the camera
	pose's third column. Asserted against Vector3 forward rather than a literal,
	so it is the convention that is being checked and not a sign."

	| ghost named |
	ghost := SRGhostAvatar new.
	named := [:name |
		ghost allDescendantsDetect: [:each | each name = name] ifNone: [nil]].
	#('GhostLeftEye' 'GhostRightEye' 'GhostLeftPupil' 'GhostRightPupil'
	  'GhostLeftRay' 'GhostRightRay' 'GhostGaze') do: [:name |
		self assert: (named value: name) notNil description: name , ' is missing'.
		self
			assert: ((named value: name) translation dot: Vector3 forward) > 0
			description: name , ' is on the back of the head'].
	"And each eye is on the side it is named for."
	self assert: ((named value: 'GhostRightEye') translation dot: Vector3 right) > 0.
	self assert: ((named value: 'GhostLeftEye') translation dot: Vector3 right) < 0.
]

{
	#category : #'tests - locomotion',
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/20/2026 13:44'
}
SRAvatarTest >> testLeaningIntoAWallDoesNotMoveTheWorld [
	"Putting your head inside something solid is not a request to be pushed
	somewhere else."

	| avatar correction |
	avatar := self avatarOnFloorAtY: 0.
	"A wall standing in the y-z plane at x = 2."
	avatar parent addChild: (SRPlane new
		scale: 4 @ 1 @ 4;
		rotation: (Quaternion angle: 90 axis: Vector3 forward);
		translation: 2 @ 2 @ 0;
		solid: true;
		yourself).
	avatar snapBodyUnderHead: 1.0 @ 1.8 @ 0 floorY: 0.
	"The head has physically crossed into the wall."
	correction := avatar
		walkCorrectionForHead: 2.0 @ 1.8 @ 0
		floorY: 0
		stickMotion: nil
		dt: 0.05.
	self assert: correction length equals: 0.
]

{
	#category : #'tests - locomotion',
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/19/2026 14:53'
}
SRAvatarTest >> testLocomotionIsOffUntilAnApplicationAsksForIt [
	"A flying camera over a scene must not be pulled to the floor by gravity, so
	the servo does nothing at all until it is switched on."

	| avatar before |
	avatar := SRAvatar new.
	self deny: avatar locomotionEnabled.
	avatar translation: 0 @ 10 @ 0.
	before := avatar translation.
	20 timesRepeat: [avatar updateLocomotion: 16].
	self assert: avatar translation equals: before.
]

{
	#category : #'tests - locomotion',
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/19/2026 15:48'
}
SRAvatarTest >> testStandingOnTheFloorDoesNotFreezeTheCorrection [
	"The freeze is for a head inside something solid. Testing the whole body box
	let the floor itself trigger it, so every frame of walking was dropped: measured
	in the live world as the body reporting solid on 400 frames of 400."

	| avatar frozen |
	avatar := self avatarOnFloorAtY: 0.
	avatar snapBodyUnderHead: 0 @ 1.8 @ 0 floorY: 0.
	frozen := 0.
	20 timesRepeat: [
		| correction |
		correction := avatar
			walkCorrectionForHead: 0 @ 1.8 @ 0
			floorY: 0
			stickMotion: 0.02 @ 0 @ 0
			dt: 0.02.
		correction length < 0.0001 ifTrue: [frozen := frozen + 1]].
	self assert: frozen equals: 0.
]

{
	#category : #'tests - locomotion',
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/19/2026 14:53'
}
SRAvatarTest >> testStickWalksOnlyInContinuousStyle [
	"The same stick aims the teleport arc in the other style. Walking off it as
	well would move the player while they were choosing where to go."

	| avatar |
	avatar := SRAvatar new.
	SRAvatar locomotionStyle: #teleport.
	self deny: avatar stickWalksThePlayer.
	SRAvatar locomotionStyle: #continuous.
	self assert: avatar stickWalksThePlayer.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (jl) 10/21/2026 11:31'
}
SRAvatarTest >> testTeleportBringsOpenMenusAlongButLeavesThePreviewBehind [
	"The preview marks where the teleport goes, so carrying it would move the
	very thing being aimed at."

	| scene avatar menu preview menuBefore target delta |
	scene := SRObject new.
	avatar := SRAvatar new translation: 10.0 @ 4.0 @ 10.0; yourself.
	avatar camera translation: -1.5 @ 1.7 @ -2.3.
	scene addChild: avatar.
	menu := SRMenu new translation: 1 @ 1.5 @ -2; yourself.
	scene addChild: menu.
	preview := SRTeleportPreview new translation: 9 @ 0 @ 9; yourself.
	scene addChild: preview.
	menuBefore := menu globalTranslation.
	self assert: (avatar travellers includes: menu).
	self deny: (avatar travellers includes: preview).

	target := 20 @ 0 @ -30.
	delta := target - (avatar camera globalTranslation x
		@ avatar globalTranslation y
		@ avatar camera globalTranslation z).
	avatar teleportTo: target.
	self assert: 0.001 > ((menu globalTranslation - (menuBefore + delta)) length).
	self assert: 0.001 > ((preview globalTranslation - (9 @ 0 @ 9)) length).
]

{
	#category : #'tests - locomotion',
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/19/2026 14:53'
}
SRAvatarTest >> testTeleportLeavesNoCorrectionToWalkOff [
	"A body left behind at the old place is walked back to the head over the
	following frames, dragging the rig with it: smooth motion the player did not
	ask for, which is the one thing teleport exists to avoid."

	| avatar head correction |
	avatar := self avatarOnFloorAtY: 0.
	head := 20.0 @ 1.8 @ -15.0.
	"A frame of ordinary walking is what leaves a rig translation to compare with."
	avatar updateLocomotion: 16.
	self deny: avatar rigWasMovedExternally.
	avatar translation: 20.0 @ 0.0 @ -15.0.
	self assert: avatar rigWasMovedExternally.
	avatar snapBodyUnderHead: head floorY: 0.
	correction := avatar
		walkCorrectionForHead: head
		floorY: 0
		stickMotion: nil
		dt: 0.05.
	self assert: correction length < 0.01.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer 10/16/2026 14:58'
}
SRAvatarTest >> testTeleportPutsTheFeetOnTheTargetNotTheRigOrigin [
	"A player who has walked across the play space stands metres from the rig
	origin. Moving the origin to the target lands them that far off their aim,
	and drops them from any height difference between the two columns."

	| avatar target feet |
	avatar := SRAvatar new.
	avatar translation: 10.0 @ 4.0 @ 10.0.
	"Head 2.7 m from the rig origin, as measured on the Index with a large room."
	avatar camera translation: -1.5 @ 1.7 @ -2.3.
	target := 30.0 @ 7.0 @ 40.0.
	avatar teleportTo: target.
	feet := avatar camera globalTranslation x
		@ avatar globalTranslation y
		@ avatar camera globalTranslation z.
	self assert: (feet - target) length < 0.0001.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer 10/16/2026 15:50'
}
SRAvatarTest >> testTurningChangesFacingWithoutMovingTheHead [
	| avatar head facing |
	avatar := SRAvatar new.
	avatar translation: 10.0 @ 0.0 @ 10.0.
	avatar camera translation: -1.5 @ 1.7 @ -2.3.
	head := avatar camera globalTranslation.
	facing := avatar camera forward.
	avatar turnBy: 90.
	self assert: (avatar camera globalTranslation - head) length < 0.0001.
	self assert: ((avatar camera forward dot: facing) abs) < 0.0001.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer 10/16/2026 15:49'
}
SRAvatarTest >> testTurningPivotsOnTheHeadNotTheRigOrigin [
	"Turning about the rig origin swings a player who has walked across the play
	space sideways through the room instead of turning them on the spot."

	| avatar before |
	avatar := SRAvatar new.
	avatar translation: 10.0 @ 0.0 @ 10.0.
	avatar camera translation: -1.5 @ 1.7 @ -2.3.
	before := avatar camera globalTranslation.
	#(45 90 90 90 45) do: [:each | avatar turnBy: each].
	self assert: ((avatar camera globalTranslation - before) length) < 0.0001.
]

{
	#category : #'tests - locomotion',
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/19/2026 14:52'
}
SRAvatarTest >> testWalkingAboutTheRoomNeverMovesTheWorldSideways [
	"On open ground the head is always right: the player really is there, so there
	is nothing to correct horizontally."

	| avatar |
	avatar := self avatarOnFloorAtY: 0.
	avatar snapBodyUnderHead: 0 @ 1.8 @ 0 floorY: 0.
	#(0.0 0.7 -1.1 0.4) do: [:x |
		| correction |
		correction := avatar
			walkCorrectionForHead: x @ 1.8 @ 0
			floorY: 0
			stickMotion: nil
			dt: 0.05.
		self assert: correction x abs < 0.0001.
		self assert: correction z abs < 0.0001].
]
