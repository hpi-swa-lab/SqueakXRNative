"
Tests for the player rig. An SRAvatar builds its own hands and camera, so locomotion can be exercised without an SRWorld -- which matters, because the only live world belongs to the person wearing the headset.
"
Class {
	#name : #SRAvatarTest,
	#superclass : #TestCase,
	#category : #'SqueakXR-Tests-Objects',
	#'squeak_changestamp' : '<historical>'
}

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
