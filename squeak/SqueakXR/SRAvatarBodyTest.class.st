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
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/19/2026 14:49'
}
SRAvatarBodyTest >> addFloorAtY: aHeight [

	^ scene addChild: (SRPlane new
		scale: 40 @ 1 @ 40;
		translation: 0 @ aHeight @ 0;
		yourself)
]

{
	#category : #running,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/19/2026 14:52'
}
SRAvatarBodyTest >> setUp [
	super setUp.
	scene := SRObject new.
	"The scene is asked on behalf of a node inside it, as it is on behalf of the
	avatar. Asking on behalf of the root would skip the whole scene, since
	everything in it is then one of the asker's own parts."
	walker := SRObject new.
	scene addChild: walker.
	body := SRAvatarBody new.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/19/2026 14:50'
}
SRAvatarBodyTest >> testAStepWithinTheStepUpHeightIsClimbedByWalkingIntoIt [

	self addFloorAtY: 0.
	"A half metre ledge covering x -5 to -1."
	scene addChild: (SRPlane new
		scale: 4 @ 1 @ 4;
		translation: -3 @ 0.5 @ 0;
		yourself).
	body restAt: Vector3 zero.
	self walk: -1.5 forFrames: 120.
	self assert: (body position y - 0.5) abs < 0.01.
	self assert: body position x < -1.5.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/19/2026 14:50'
}
SRAvatarBodyTest >> testAWallStopsTheBodyWithoutLiftingIt [
	"The mobs climb by jumping into whatever they walked into, which makes pressing
	against a tall wall bounce. A head may not bounce."

	self addFloorAtY: 0.
	scene addChild: (SRPlane new
		scale: 4 @ 1 @ 4;
		rotation: (Quaternion angle: 90 axis: Vector3 forward);
		translation: 2 @ 2 @ 0;
		yourself).
	body restAt: Vector3 zero.
	self walk: 1.5 forFrames: 120.
	self assert: body position x < 2.0.
	self assert: body position x > 1.0.
	self assert: body position y abs < 0.01.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/19/2026 14:52'
}
SRAvatarBodyTest >> testAnObjectWithoutCollisionGeometryHoldsNobodyUp [
	"Offering collision geometry is the whole of what makes an object solid, and
	SRCube offers none: it would otherwise make every cube in every scene pickable
	and grabbable as well as walkable."

	scene addChild: (SRCube new scale: 10 @ 10 @ 10; yourself).
	body restAt: 0 @ 5 @ 0.
	80 timesRepeat: [body applyPhysicsIn: walker dt: 0.02].
	self deny: body onGround.
	"Out the bottom of a cube reaching from -5 to 5."
	self assert: body position y < -5.0.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/19/2026 14:52'
}
SRAvatarBodyTest >> testFallingLandsOnTheFloorAndStaysThere [
	"Stopping at the last free substep instead of settling onto the surface leaves
	the player hovering a substep up, and falling again every frame."

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
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/19/2026 15:48'
}
SRAvatarBodyTest >> testRestingLeavesTheBoxClearOfTheSurface [
	"Resting exactly on contact puts the box's bottom face on a voxel boundary, and
	the cell lookup runs through single precision, so the boundary floors into the
	solid block below and the overlap flickers frame to frame. Measured in a tunnel:
	feet at cell 3.999 instead of 4."

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
	#category : #building,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/19/2026 14:52'
}
SRAvatarBodyTest >> walk: metresPerSecondX forFrames: aCount [
	"The velocity is reasserted every frame because the stick does: the walk
	correction sets it from the stick each time it is read."

	aCount timesRepeat: [
		body velocityX: metresPerSecondX z: 0.0.
		body applyPhysicsIn: walker dt: 0.02].
]
