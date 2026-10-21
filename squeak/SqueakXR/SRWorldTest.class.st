"
Covers the between-frame action queue, which used to be a class variable: the blocks capture the world and whatever they were about to add to it, so a stopped world that kept them kept all of it.
"
Class {
	#name : #SRWorldTest,
	#superclass : #TestCase,
	#instVars : [
		'world',
		'previousWorld'
	],
	#category : #'SqueakXR-Tests-Objects',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #running,
	#'squeak_changestamp' : 'MCPServer 9/25/2026 13:16'
}
SRWorldTest >> setUp [
	"SRWorld>>isRunning: installs the receiver as SRWorld current, so it has to be put back."

	super setUp.
	previousWorld := SRWorld current.
	world := SRWorld new.
]

{
	#category : #running,
	#'squeak_changestamp' : 'MCPServer 10/12/2026 17:45'
}
SRWorldTest >> tearDown [
	"isRunning: true has no process behind it here, and a world left running breaks
	SRWorld allInstances select: [:w | w isRunning]."

	world isRunning: false.
	SRWorld current: previousWorld.
	super tearDown.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer 9/25/2026 13:17'
}
SRWorldTest >> testDeferredActionIsRefusedWhileNotRunning [
	world addDeferredFrameMessage: [self signalFailure: 'must not run'].
	self assert: world pendingFrameActions isEmpty.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer 9/25/2026 13:17'
}
SRWorldTest >> testDeferredActionRunsOnTheNextCycle [
	| ran |
	ran := false.
	world isRunning: true.
	world addDeferredFrameMessage: [ran := true].
	world runPendingBetweenFrameActions.
	self assert: ran.
	self assert: world pendingFrameActions isEmpty.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer 9/25/2026 13:17'
}
SRWorldTest >> testStopDropsDeferredActions [
	world isRunning: true.
	world addDeferredFrameMessage: [self signalFailure: 'must not run'].
	self deny: world pendingFrameActions isEmpty.
	world stop.
	self assert: world pendingFrameActions isEmpty.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (jl) 10/21/2026 10:15'
}
SRWorldTest >> testTheEmptyHolodeckHasAFloorEveryLocomotionCanUse [
	"Walking, teleporting and the arc preview all ask the scene the same two
	questions. One unbounded collider at y = 0 answers both, so none of them
	needs its own idea of where the bottom of the world is."

	| floor body arc probe |
	floor := world collisionGeometry.
	self deny: floor isBounded.
	"Asked on behalf of a node inside the world, as it is on behalf of the avatar."
	probe := SRObject new.
	world addChild: probe.
	"The box sweep, which is what stops the avatar walking."
	body := SRAvatarBody new.
	body restAt: 400 @ 5 @ -400.
	80 timesRepeat: [body applyPhysicsIn: (SRSceneSolids forObject: probe) dt: 0.02].
	self assert: body position y abs < 0.01.
	self assert: body onGround.
	"The teleport ray."
	self
		assert: ((SRRay origin: 400 @ 5 @ -400 forward: Vector3 down)
			castNearestSolid: world) point y abs < 0.001.
	"The arc preview, which must agree with where the teleport lands."
	arc := SRBallisticArc new
		origin: 0 @ 2 @ 0 direction: (Vector3 x: 0 y: 0.2 z: -1) normalized;
		castIn: world;
		yourself.
	self assert: arc hit notNil.
	self assert: arc hit point y abs < 0.05.
]
