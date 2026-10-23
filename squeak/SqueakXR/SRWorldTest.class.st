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
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 15:00'
}
SRWorldTest >> setUp [

	super setUp.
	previousWorld := SRWorld current.
	world := SRWorld new.
]

{
	#category : #running,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 15:01'
}
SRWorldTest >> tearDown [
	"A world left running breaks SRWorld allInstances select: [:w | w isRunning]."
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
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 15:00'
}
SRWorldTest >> testTheEmptyHolodeckHasAFloorEveryLocomotionCanUse [

	| floor body arc probe |
	floor := world collisionGeometry.
	self deny: floor isBounded.

	probe := SRObject new.
	world addChild: probe.

	body := SRAvatarBody new.
	body restAt: 400 @ 5 @ -400.
	80 timesRepeat: [body applyPhysicsIn: (SRSceneSolids forObject: probe) dt: 0.02].
	self assert: body position y abs < 0.01.
	self assert: body onGround.

	self
		assert: ((SRRay origin: 400 @ 5 @ -400 forward: Vector3 down)
			castNearestSolid: world) point y abs < 0.001.

	arc := SRBallisticArc new
		origin: 0 @ 2 @ 0 direction: (Vector3 x: 0 y: 0.2 z: -1) normalized;
		castIn: world;
		yourself.
	self assert: arc hit notNil.
	self assert: arc hit point y abs < 0.05.
]
