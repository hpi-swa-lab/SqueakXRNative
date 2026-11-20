"
Covers the between-frame action queue, which used to be a class variable: the blocks capture the world and whatever they were about to add to it, so a stopped world that kept them kept all of it.
"
Class {
	#name : #SRWorldTest,
	#superclass : #TestCase,
	#instVars : [
		'world',
		'previousWorld',
		'savedHolodeckFloor',
		'savedFloorBackground'
	],
	#category : #'SqueakXR-Tests-Objects',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #helpers,
	#'squeak_changestamp' : 'leo-MCPServer 11/20/2026 18:11'
}
SRWorldTest >> floorPartsRendered [

	| renderer |
	renderer := SRWorldTestRenderer new.
	world renderOn: renderer.
	^ renderer rendered asArray
]

{
	#category : #running,
	#'squeak_changestamp' : 'leo-MCPServer 11/20/2026 18:11'
}
SRWorldTest >> setUp [

	super setUp.
	previousWorld := SRWorld current.
	savedHolodeckFloor := SRWorld classPool at: #HolodeckFloor.
	savedFloorBackground := SRRenderer classPool at: #FloorBackground.
	world := SRWorld new.
]

{
	#category : #running,
	#'squeak_changestamp' : 'leo-MCPServer 11/20/2026 18:11'
}
SRWorldTest >> tearDown [
	"A world left running breaks SRWorld allInstances select: [:w | w isRunning]."
	world isRunning: false.
	SRWorld current: previousWorld.
	SRWorld classPool at: #HolodeckFloor put: savedHolodeckFloor.
	SRRenderer classPool at: #FloorBackground put: savedFloorBackground.
	super tearDown.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 16:22'
}
SRWorldTest >> testANewWorldHasNotRunItsStartScript [

	self deny: world hasRunStartScript
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
	#'squeak_changestamp' : 'MCPServer (jl) 11/16/2026 11:14'
}
SRWorldTest >> testFallingEndsAtBedrockEvenWithNothingThere [

	| body |
	SRWorld holodeckFloor: false.
	body := SRAvatarBody new.
	body restAt: 400 @ 5 @ -400.
	100 timesRepeat: [body applyPhysicsIn: (SRSceneSolids forObject: world) dt: 0.02].
	self assert: (body position y between: SRAvatarBody bedrock and: SRAvatarBody bedrock + 1cm).
	self assert: body onGround.

	body restAt: 0 @ -3 @ 0.
	body applyPhysicsIn: (SRSceneSolids forObject: world) dt: 0.02.
	self assert: body position y >= SRAvatarBody bedrock.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (leo) 10/30/2026 17:05'
}
SRWorldTest >> testFrameCollectsLights [

	| light |
	light := SRPointLight new.
	world addChild: (SRObject new addChild: light; yourself).
	
	SRFrame world: world deltaTime: 0.
	
	self assert: {light} equals: world lightsBuffer asArray.
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
	#'squeak_changestamp' : 'leo-MCPServer 11/20/2026 18:26'
}
SRWorldTest >> testTheCursorRayPassesThroughTheHolodeckFloor [

	| target cursor hits |
	SRWorld holodeckFloor: true.
	target := SRCube new translation: 0 @ -2 @ 0; yourself.
	world addChild: target.
	cursor := SRCursor new.
	hits := cursor castRayOn: (cursor targetsIn: world) from: 0 @ 2 @ 0 toward: Vector3 down.
	self assert: {target} equals: (hits collect: [:each | each object]) asArray.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/20/2026 18:11'
}
SRWorldTest >> testTheFloorBackgroundIsShownByDefault [

	SRRenderer classPool at: #FloorBackground put: nil.
	SRWorld holodeckFloor: true.
	self assert: #(#slab #grid) equals: self floorPartsRendered.
	self assert: SRRenderer floorColor equals: SRRenderer visibleFloorColor.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (jl) 11/16/2026 10:50'
}
SRWorldTest >> testTheHolodeckFloorLetsTheAvatarWalkWithoutAnApp [

	| avatar |
	avatar := SRAvatar new.
	world addChild: avatar.
	SRWorld holodeckFloor: false.
	self deny: avatar locomotionEnabled.
	SRWorld holodeckFloor: true.
	self assert: avatar locomotionEnabled.
	avatar locomotionEnabled: false.
	self deny: avatar locomotionEnabled.
	avatar useDefaultLocomotion.
	self assert: avatar locomotionEnabled.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (jl) 11/16/2026 11:14'
}
SRWorldTest >> testTheHolodeckPlatformEndsWhereTheGridEnds [

	| edge |
	SRWorld holodeckFloor: true.
	edge := world holodeckSize / 2.
	self assert: ((SRRay origin: (edge - 0.1) @ 5 @ 0 forward: Vector3 down) castNearestSolid: world) notNil.
	self assert: ((SRRay origin: (edge + 0.1) @ 5 @ 0 forward: Vector3 down) castNearestSolid: world) isNil.
	self assert: ((SRRay origin: 0 @ 5 @ (edge + 0.1) negated forward: Vector3 down) castNearestSolid: world) isNil.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (jl) 11/16/2026 11:03'
}
SRWorldTest >> testTheHolodeckPlatformIsAFloorEveryLocomotionCanUse [

	| body arc probe |
	SRWorld holodeckFloor: true.
	probe := SRObject new.
	world addChild: probe.

	body := SRAvatarBody new.
	body restAt: 5 @ 5 @ -5.
	80 timesRepeat: [body applyPhysicsIn: (SRSceneSolids forObject: probe) dt: 0.02].
	self assert: body position y abs < 0.01.
	self assert: body onGround.

	self
		assert: ((SRRay origin: 5 @ 5 @ -5 forward: Vector3 down)
			castNearestSolid: world) point y abs < 0.001.

	arc := SRBallisticArc new
		origin: 0 @ 2 @ 0 direction: (Vector3 x: 0 y: 0.2 z: -1) normalized;
		castIn: world;
		yourself.
	self assert: arc hit notNil.
	self assert: arc hit point y abs < 0.05.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 16:22'
}
SRWorldTest >> testTheStartScriptRunsOnlyOnce [

	| savedRunInFlat |
	savedRunInFlat := SRWorld classPool at: #RunStartScriptInFlat.
	[SRWorld runStartScriptInFlat: false.
	world runStartScriptOnce.
	SRWorld runStartScriptInFlat: true.
	world runStartScriptOnce.
	self assert: world hasRunStartScript.
	self deny: (world children anySatisfy: [:each | each isMorphPanel])]
		ensure: [SRWorld classPool at: #RunStartScriptInFlat put: savedRunInFlat]
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (jl) 11/16/2026 11:05'
}
SRWorldTest >> testWalkingStopsAtThePlatformEdge [

	| avatar edge kept |
	SRWorld holodeckFloor: true.
	avatar := SRAvatar new.
	world addChild: avatar.
	edge := world holodeckSize / 2 - avatar body halfWidth.

	kept := avatar keepOnHolodeck: 1 @ 0 @ -1 feet: (edge - 0.5) @ 0 @ 0.
	self assert: (kept x closeTo: 0.5).
	self assert: (kept z closeTo: -1).

	kept := avatar keepOnHolodeck: 1 @ 0 @ 0 feet: (edge - 0.5) @ 10 @ 0.
	self assert: (kept x closeTo: 1).

	kept := avatar keepOnHolodeck: 0 @ -1 @ 0 feet: (edge + 1) @ 0 @ 0.
	self assert: (kept y closeTo: -1).
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/20/2026 18:11'
}
SRWorldTest >> testWithoutTheFloorBackgroundOnlyTheGridIsShown [

	SRRenderer floorBackground: false.
	SRWorld holodeckFloor: true.
	self assert: #(#grid) equals: self floorPartsRendered.
	self assert: 0 equals: SRRenderer visibleFloorColor alpha.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (jl) 11/16/2026 10:50'
}
SRWorldTest >> testWithoutTheHolodeckFloorTheEmptyWorldHasNothingToStandOn [

	SRWorld holodeckFloor: false.
	self assert: world collisionGeometry isNil.
	self assert: ((SRRay origin: 0 @ 5 @ 0 forward: Vector3 down) castNearestSolid: world) isNil.
]
