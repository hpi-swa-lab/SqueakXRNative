"
The player's collision volume, in metres and global scene space. It is not an SRObject and never joins the scene graph: the avatar rig is what the player sees moved, and this only decides where the rig is allowed to be.

Solidity comes from SRObject>>solidInBoxCenter:halfExtents:, so any object with collision geometry stops the player and no class knows about terrain in particular.

position is the feet, matching SRAvatar>>translation, which OpenXR STAGE space puts on the physical floor.
"
Class {
	#name : #SRAvatarBody,
	#superclass : #Object,
	#instVars : [
		'position',
		'velocity',
		'height',
		'onGround'
	],
	#category : #'SqueakXR-Objects',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #physics,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/19/2026 15:30'
}
SRAvatarBody >> applyPhysicsIn: aScene dt: dt [
	"Past about half a body width a step tunnels through a wall and the player jams
	against its far side instead of being stopped by it, hence the substeps."

	| steps h speed |
	speed := (((velocity x * velocity x) + (velocity z * velocity z)) sqrt)
		max: velocity y abs.
	steps := ((speed * dt / (self halfWidth / 2)) ceiling max: 1) min: 16.
	h := dt / steps.
	steps timesRepeat: [self integrateIn: aScene dt: h].
]

{
	#category : #dimensions,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/19/2026 14:41'
}
SRAvatarBody >> centreForFeet: aPosition [

	^ Vector3
		x: aPosition x
		y: aPosition y + (self height / 2)
		z: aPosition z
]

{
	#category : #physics,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/19/2026 15:30'
}
SRAvatarBody >> climbTo: aBlockedPosition in: aScene [
	"A blocked horizontal step, retried with the feet lifted: if the body fits up
	there the obstacle was a stair, and settling back down puts the feet on it
	within the same substep. The mobs jump instead, which makes pressing into a
	tall wall bounce -- tolerable for a rabbit, not for a head."

	| lifted |
	onGround ifFalse: [^ false].
	lifted := Vector3
		x: aBlockedPosition x
		y: aBlockedPosition y + self stepUpHeight
		z: aBlockedPosition z.
	(self collidesAtFeet: lifted in: aScene) ifTrue: [^ false].
	position := Vector3
		x: lifted x
		y: (self settledYBetween: lifted y and: aBlockedPosition y in: aScene)
		z: lifted z.
	^ true
]

{
	#category : #physics,
	#'squeak_changestamp' : 'MCPServer (jl) 10/21/2026 10:14'
}
SRAvatarBody >> collidesAtFeet: aPosition in: aScene [
	"aScene is anything answering #solidInBoxCenter:halfExtents: -- an SRObject, or
	an SRSceneSolids snapshot of one when the same frame asks many times."

	^ aScene
		solidInBoxCenter: (self centreForFeet: aPosition)
		halfExtents: self halfExtents
]

{
	#category : #physics,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/19/2026 15:30'
}
SRAvatarBody >> collidesIn: aScene [

	^ self collidesAtFeet: position in: aScene
]

{
	#category : #physics,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/19/2026 14:41'
}
SRAvatarBody >> feetAtX: aX z: aZ [
	"Horizontal placement with no resistance: a step the player took on the real
	floor cannot be refused, only the stick can."

	position := Vector3 x: aX y: position y z: aZ.
]

{
	#category : #physics,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/19/2026 14:41'
}
SRAvatarBody >> gravity [
	"Metres per second squared. The mobs fall at a game-feel 24 cells/s^2; a player
	standing in a metre-sized world notices Earth being wrong."

	^ 9.81
]

{
	#category : #dimensions,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/19/2026 14:41'
}
SRAvatarBody >> halfExtents [
	"Pulled in by a millimetre on every axis, otherwise a body resting exactly on
	a surface reports it as a collision and can never be at rest."

	| epsilon |
	epsilon := 1 mm.
	^ Vector3
		x: self halfWidth - epsilon
		y: (self height / 2) - epsilon
		z: self halfWidth - epsilon
]

{
	#category : #dimensions,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/19/2026 14:41'
}
SRAvatarBody >> halfWidth [

	^ 30 cm
]

{
	#category : #physics,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/19/2026 15:47'
}
SRAvatarBody >> headInSolidAt: aHeadPosition in: aScene [
	"Only the head. Testing the whole body box instead freezes the correction
	whenever the legs meet a step, which is the case #climbTo:in: exists to handle,
	so walking at rising ground dropped the frame rather than climbing it."

	| half |
	half := 12 cm.
	^ aScene
		solidInBoxCenter: aHeadPosition
		halfExtents: (Vector3 x: half y: half z: half)
]

{
	#category : #dimensions,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/19/2026 14:41'
}
SRAvatarBody >> height [

	^ height ifNil: [180 cm]
]

{
	#category : #dimensions,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/19/2026 14:41'
}
SRAvatarBody >> height: metres [
	"A headset put down on a desk tracks at floor level, and a zero-height body
	fits through anything."

	height := metres max: 50 cm
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/19/2026 14:41'
}
SRAvatarBody >> initialize [
	super initialize.
	position := Vector3 zero.
	velocity := Vector3 zero.
	onGround := false.
]

{
	#category : #physics,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/20/2026 15:26'
}
SRAvatarBody >> integrateIn: aScene dt: dt [
	"One axis at a time: resolving all three at once cannot tell being stopped by
	a wall from being stopped by the floor. A grounded body is asked whether it is
	still supported rather than made to fall and find out, so taking the ground
	out from under the player still drops them."

	| alongX alongZ alongY |
	onGround := onGround and: [self stillSupportedIn: aScene].
	velocity := Vector3
		x: velocity x
		y: (onGround
			ifTrue: [0.0]
			ifFalse: [(velocity y - (self gravity * dt)) max: self maxFallSpeed negated])
		z: velocity z.

	alongX := Vector3 x: position x + (velocity x * dt) y: position y z: position z.
	(self collidesAtFeet: alongX in: aScene)
		ifTrue: [self climbTo: alongX in: aScene]
		ifFalse: [position := alongX].

	alongZ := Vector3 x: position x y: position y z: position z + (velocity z * dt).
	(self collidesAtFeet: alongZ in: aScene)
		ifTrue: [self climbTo: alongZ in: aScene]
		ifFalse: [position := alongZ].

	"Only fall when not standing on something. The feet rest #skinWidth clear of
	the surface, so a supported body never collides at its own position, and
	running this while grounded answered 'no floor' every frame -- a permanent
	bounce of exactly that gap."
	onGround ifTrue: [^ self].

	alongY := Vector3 x: position x y: position y + (velocity y * dt) z: position z.
	(self collidesAtFeet: alongY in: aScene)
		ifTrue: [
			"Settling costs ten sweeps, so it is done on landing only."
			velocity y <= 0 ifTrue: [
				position := Vector3
					x: position x
					y: (self settledYBetween: position y and: alongY y in: aScene)
					z: position z.
				onGround := true].
			velocity := Vector3 x: velocity x y: 0.0 z: velocity z]
		ifFalse: [position := alongY].
]

{
	#category : #physics,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/19/2026 14:42'
}
SRAvatarBody >> maxFallSpeed [
	"A fall into empty scene accelerates without limit, and the substep count is
	proportional to speed: unclamped, falling out of the world costs an unbounded
	number of sweeps per frame."

	^ 20 m
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/19/2026 14:41'
}
SRAvatarBody >> onGround [

	^ onGround
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/19/2026 14:41'
}
SRAvatarBody >> position [

	^ position
]

{
	#category : #physics,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/19/2026 15:30'
}
SRAvatarBody >> restAt: aPosition [
	"Placed rather than walked: a teleport must not carry the old velocity into the
	new spot. Not on the ground until a sweep says so, which is what makes the next
	frame settle it onto the surface instead of leaving it wherever it was put."

	position := aPosition.
	velocity := Vector3 zero.
	onGround := false.
]

{
	#category : #physics,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/19/2026 15:48'
}
SRAvatarBody >> settledYBetween: aFreeY and: aBlockedY in: aScene [
	"The lowest height the body may occupy, by halving the gap. A generic collider
	cannot be asked where a surface is, only whether a box is clear, and stopping
	at the last free substep would leave the player hovering a substep up."

	| free blocked mid |
	free := aFreeY.
	blocked := aBlockedY.
	10 timesRepeat: [
		mid := (free + blocked) / 2.
		(self collidesAtFeet: (Vector3 x: position x y: mid z: position z) in: aScene)
			ifTrue: [blocked := mid]
			ifFalse: [free := mid]].
	"Away from the blocked side, so the result stays clear."
	^ free + self skinWidth
]

{
	#category : #dimensions,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/19/2026 15:48'
}
SRAvatarBody >> skinWidth [
	"Clearance left above a surface after settling. Resting exactly on contact puts
	the box's bottom face on a voxel boundary, and SWAGameXR>>cellPositionForGlobal:
	runs through single precision, so the boundary reads as 3.99999993 and floors
	into the solid block below. The overlap then flickers frame to frame."

	^ 3 mm
]

{
	#category : #physics,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/19/2026 14:41'
}
SRAvatarBody >> stepUpHeight [
	"How high a rise walking into it climbs. One metre clears a block in a world
	scaled to a metre per cell, which is the only scale locomotion runs at."

	^ 1 m
]

{
	#category : #physics,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/20/2026 15:25'
}
SRAvatarBody >> stillSupportedIn: aScene [
	"Settling leaves the feet #skinWidth clear of the surface, so a grounded body
	has to be asked whether the floor is still there. Falling to find out means
	falling exactly that gap, every frame, for ever."

	^ self
		collidesAtFeet: (Vector3 x: position x y: position y - (self skinWidth * 2) z: position z)
		in: aScene
]

{
	#category : #physics,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/19/2026 14:41'
}
SRAvatarBody >> velocityX: anX z: aZ [
	"Horizontal only: the vertical component belongs to gravity, which the player
	does not drive."

	velocity := Vector3 x: anX y: velocity y z: aZ.
]
