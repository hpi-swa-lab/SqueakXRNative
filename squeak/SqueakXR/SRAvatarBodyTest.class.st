"
The scenes here are detached SRObject trees: SRObject>>solidInBoxCenter:halfExtents: searches from #sceneRoot, so no SRWorld is needed and the only live world belongs to whoever is wearing the headset.

Floors and walls are SRPlanes because a plane is the one SqueakXR collision shape with a production class behind it; SRCube deliberately has no collision geometry.
"
Class {
	#name : #SRAvatarBodyTest,
	#superclass : #TestCase,
	#instVars : [
		'scene',
		'walker',
		'body'
	],
	#category : #'SqueakXR-Tests-Objects',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #building,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/20/2026 13:43'
}
SRAvatarBodyTest >> addFloorAtY: aHeight [

	^ scene addChild: (SRPlane new
		scale: 40 @ 1 @ 40;
		translation: 0 @ aHeight @ 0;
		solid: true;
		yourself)
]

{
	#category : #fixtures,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 15:01'
}
SRAvatarBodyTest >> holodeckFloor [
	"Not built from an SRWorld: instantiating one registers a project and a change set."
	^ SRSceneSolids new setGeometries:
		{SRCollisionPlane point: Vector3 zero normal: Vector3 up}

]

{
	#category : #running,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 14:59'
}
SRAvatarBodyTest >> setUp [
	super setUp.
	scene := SRObject new.

	walker := SRObject new.
	scene addChild: walker.
	body := SRAvatarBody new.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 14:59'
}
SRAvatarBodyTest >> testAStandingBodyDoesNotDrift [

	| resting |
	self addFloorAtY: 0.
	body restAt: Vector3 zero.
	self walk: 0 forFrames: 5.
	resting := body position.
	self walk: 0 forFrames: 120.
	self assert: body onGround.
	self assert: (body position - resting) length < 1.0e-6.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 14:59'
}
SRAvatarBodyTest >> testAStepWithinTheStepUpHeightIsClimbedByWalkingIntoIt [

	self addFloorAtY: 0.

	scene addChild: (SRPlane new
		scale: 4 @ 1 @ 4;
		translation: -3 @ 0.5 @ 0;
		solid: true;
		yourself).
	body restAt: Vector3 zero.
	self walk: -1.5 forFrames: 120.
	self assert: (body position y - 0.5) abs < 0.01.
	self assert: body position x < -1.5.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 14:59'
}
SRAvatarBodyTest >> testAWallStopsTheBodyWithoutLiftingIt [

	self addFloorAtY: 0.
	scene addChild: (SRPlane new
		scale: 4 @ 1 @ 4;
		rotation: (Quaternion angle: 90 axis: Vector3 forward);
		translation: 2 @ 2 @ 0;
		solid: true;
		yourself).
	body restAt: Vector3 zero.
	self walk: 1.5 forFrames: 120.
	self assert: body position x < 2.0.
	self assert: body position x > 1.0.
	self assert: body position y abs < 0.01.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 14:59'
}
SRAvatarBodyTest >> testAnEmptySceneStillStopsTheBodyAtTheWorldFloor [

	| floor |
	floor := self holodeckFloor.
	body restAt: 0 @ 5 @ 0.
	80 timesRepeat: [body applyPhysicsIn: floor dt: 0.02].
	self assert: body position y abs < 0.01.
	self assert: body onGround.
	40 timesRepeat: [body applyPhysicsIn: floor dt: 0.02].
	self assert: body position y abs < 0.01.

	body restAt: 400 @ 5 @ -400.
	80 timesRepeat: [body applyPhysicsIn: floor dt: 0.02].
	self assert: body position y abs < 0.01.
	self assert: body onGround.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 14:59'
}
SRAvatarBodyTest >> testAnObjectWithoutCollisionGeometryHoldsNobodyUp [

	scene addChild: (SRCube new scale: 10 @ 10 @ 10; yourself).
	body restAt: 0 @ 5 @ 0.
	80 timesRepeat: [body applyPhysicsIn: walker dt: 0.02].
	self deny: body onGround.

	self assert: body position y < -5.0.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 14:59'
}
SRAvatarBodyTest >> testFallingLandsOnTheFloorAndStaysThere [

	self addFloorAtY: 0.
	body restAt: 0 @ 5 @ 0.
	80 timesRepeat: [body applyPhysicsIn: walker dt: 0.02].
	self assert: body position y abs < 0.01.
	self assert: body onGround.
	40 timesRepeat: [body applyPhysicsIn: walker dt: 0.02].
	self assert: body position y abs < 0.01.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 14:59'
}
SRAvatarBodyTest >> testRestingLeavesTheBoxClearOfTheSurface [

	| bottom |
	self addFloorAtY: 0.
	body restAt: 0 @ 3 @ 0.
	200 timesRepeat: [body applyPhysicsIn: walker dt: 0.02].
	self assert: body onGround.
	bottom := body position y + (body height / 2) - body halfExtents y.
	self assert: bottom > 0.001.
	self assert: body position y < 0.01.
	self deny: (body collidesIn: walker).
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 14:59'
}
SRAvatarBodyTest >> testTakingTheFloorAwayStillDropsTheBody [

	| plane probe restingY |
	plane := SRPlane new
		scale: 40 @ 1 @ 40;
		solid: true;
		yourself.
	scene addChild: plane.
	probe := SRObject new.
	scene addChild: probe.
	body restAt: Vector3 zero.

	5 timesRepeat: [body applyPhysicsIn: (SRSceneSolids forObject: probe) dt: 0.02].
	self assert: body onGround.
	restingY := body position y.
	plane remove.
	30 timesRepeat: [body applyPhysicsIn: (SRSceneSolids forObject: probe) dt: 0.02].
	self deny: body onGround.
	self assert: body position y < (restingY - 0.1).
]

{
	#category : #building,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 14:59'
}
SRAvatarBodyTest >> walk: metresPerSecondX forFrames: aCount [

	aCount timesRepeat: [
		body velocityX: metresPerSecondX z: 0.0.
		body applyPhysicsIn: walker dt: 0.02].
]
