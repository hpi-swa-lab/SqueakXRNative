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
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 14:58'
}
SRAvatarBody >> applyPhysicsIn: aScene dt: dt [

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
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 14:58'
}
SRAvatarBody >> climbTo: aBlockedPosition in: aScene [

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
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 14:58'
}
SRAvatarBody >> collidesAtFeet: aPosition in: aScene [

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
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 14:58'
}
SRAvatarBody >> feetAtX: aX z: aZ [

	position := Vector3 x: aX y: position y z: aZ.
]

{
	#category : #physics,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 14:58'
}
SRAvatarBody >> gravity [

	^ 9.81
]

{
	#category : #dimensions,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 14:58'
}
SRAvatarBody >> halfExtents [

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
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 14:58'
}
SRAvatarBody >> headInSolidAt: aHeadPosition in: aScene [

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
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 14:58'
}
SRAvatarBody >> height: metres [

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
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 14:58'
}
SRAvatarBody >> integrateIn: aScene dt: dt [

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

	onGround ifTrue: [^ self].

	alongY := Vector3 x: position x y: position y + (velocity y * dt) z: position z.
	(self collidesAtFeet: alongY in: aScene)
		ifTrue: [

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
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 14:58'
}
SRAvatarBody >> maxFallSpeed [

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
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 14:59'
}
SRAvatarBody >> restAt: aPosition [

	position := aPosition.
	velocity := Vector3 zero.
	onGround := false.
]

{
	#category : #physics,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 14:59'
}
SRAvatarBody >> settledYBetween: aFreeY and: aBlockedY in: aScene [

	| free blocked mid |
	free := aFreeY.
	blocked := aBlockedY.
	10 timesRepeat: [
		mid := (free + blocked) / 2.
		(self collidesAtFeet: (Vector3 x: position x y: mid z: position z) in: aScene)
			ifTrue: [blocked := mid]
			ifFalse: [free := mid]].

	^ free + self skinWidth
]

{
	#category : #dimensions,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 15:01'
}
SRAvatarBody >> skinWidth [
	"Clearance left above a surface. Resting exactly on contact puts the box on a voxel 
	boundary, which single precision floors into the block below."
	^ 3 mm

]

{
	#category : #physics,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 14:59'
}
SRAvatarBody >> stepUpHeight [

	^ 1 m
]

{
	#category : #physics,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 14:59'
}
SRAvatarBody >> stillSupportedIn: aScene [

	^ self
		collidesAtFeet: (Vector3 x: position x y: position y - (self skinWidth * 2) z: position z)
		in: aScene
]

{
	#category : #physics,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 14:59'
}
SRAvatarBody >> velocityX: anX z: aZ [

	velocity := Vector3 x: anX y: velocity y z: aZ.
]
