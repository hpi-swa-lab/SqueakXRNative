"
I am a pistol built from primitives. Grab me (squeeze / right mouse button) and I snap into the hand; pull the trigger (left mouse button) to fire. Every shot shows a muzzle flash, kicks the gun back and up, and spawns a tracer bullet.

The barrel points along my local forward (-Z); my origin sits at the top of the grip, which is also the pivot for the recoil.
"
Class {
	#name : #SRGun,
	#superclass : #SRObject,
	#instVars : [
		'hand',
		'muzzleFlash',
		'recoil',
		'cooldown'
	],
	#category : #'SqueakXR-Objects',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #constants,
	#'squeak_changestamp' : 'MCPServer (leo) 10/29/2026 13:37'
}
SRGun class >> bulletSpeed [
	"meters per second"

	^ 40
]

{
	#category : #constants,
	#'squeak_changestamp' : 'MCPServer (leo) 10/29/2026 13:37'
}
SRGun class >> fireInterval [
	"minimum milliseconds between two shots"

	^ 120
]

{
	#category : #constants,
	#'squeak_changestamp' : 'MCPServer (leo) 10/29/2026 13:37'
}
SRGun class >> recoilAngle [
	"degrees the muzzle tips up at the peak of the recoil"

	^ 15
]

{
	#category : #constants,
	#'squeak_changestamp' : 'MCPServer (leo) 10/29/2026 13:37'
}
SRGun class >> recoilHalfLife [
	"milliseconds until the recoil has settled halfway back"

	^ 40
]

{
	#category : #constants,
	#'squeak_changestamp' : 'MCPServer (leo) 10/29/2026 13:37'
}
SRGun class >> recoilKickback [

	^ 5cm
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'MCPServer (leo) 10/29/2026 13:37'
}
SRGun >> addPart: aColor size: sizeVector3 at: positionVector3 [

	^ self addPart: aColor size: sizeVector3 at: positionVector3 tilt: 0
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'MCPServer (leo) 10/29/2026 13:37'
}
SRGun >> addPart: aColor size: sizeVector3 at: positionVector3 tilt: degreesAroundRight [

	| part |
	part := SRCube new
		color: aColor;
		scale: sizeVector3;
		translation: positionVector3;
		rotation: (Quaternion angle: degreesAroundRight axis: Vector3 right);
		yourself.
	self addChild: part.
	^ part
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'MCPServer (leo) 10/29/2026 13:37'
}
SRGun >> buildModel [

	| metal dark grip accent gripTilt |
	metal := Color r: 0.32 g: 0.34 b: 0.38.
	dark := Color r: 0.12 g: 0.12 b: 0.14.
	grip := Color r: 0.24 g: 0.18 b: 0.13.
	accent := Color r: 1.0 g: 0.45 b: 0.1.
	"the grip leans back so that the bottom of it points towards the wrist"
	gripTilt := -15.
	
	"slide, frame and barrel"
	self addPart: metal size: 3cm @ 3.2cm @ 19cm at: 0 @ 1.6cm @ -5.5cm.
	self addPart: dark size: 2.8cm @ 1.6cm @ 15cm at: 0 @ -0.4cm @ -5cm.
	self addPart: accent size: 3.1cm @ 0.4cm @ 13cm at: 0 @ 0.2cm @ -7cm.
	self addPart: dark size: 1.8cm @ 1.8cm @ 3cm at: 0 @ 1.6cm @ -16cm.
	self addPart: accent size: 2.3cm @ 2.3cm @ 0.8cm at: 0 @ 1.6cm @ -17.6cm.
	
	"slide details: serrations, ejection port and sights"
	#(1.2 2.2 3.2) do: [:z |
		self addPart: dark size: 3.1cm @ 2.2cm @ 0.3cm at: 0 @ 1.8cm @ z cm].
	self addPart: dark size: 0.3cm @ 1.2cm @ 3.5cm at: 1.4cm @ 2.2cm @ -4cm.
	self addPart: dark size: 2.4cm @ 0.8cm @ 0.8cm at: 0 @ 3.5cm @ 3cm.
	self addPart: dark size: 0.6cm @ 0.8cm @ 0.6cm at: 0 @ 3.5cm @ -14cm.
	
	"grip with side panels and magazine base plate"
	self addPart: grip size: 2.6cm @ 10cm @ 4cm at: 0 @ -5.5cm @ 2.2cm tilt: gripTilt.
	self addPart: dark size: 2.9cm @ 7cm @ 3cm at: 0 @ -5.8cm @ 2.3cm tilt: gripTilt.
	self addPart: accent size: 3cm @ 1cm @ 4.6cm at: 0 @ -10.5cm @ 3.55cm tilt: gripTilt.
	
	"trigger guard and trigger"
	self addPart: dark size: 1cm @ 0.6cm @ 5.5cm at: 0 @ -3.6cm @ -3.2cm.
	self addPart: dark size: 1cm @ 2.6cm @ 0.6cm at: 0 @ -2.4cm @ -5.8cm.
	self addPart: accent size: 0.6cm @ 2.2cm @ 0.7cm at: 0 @ -2.1cm @ -1.6cm tilt: 10.
]

{
	#category : #collisions,
	#'squeak_changestamp' : 'MCPServer (leo) 10/29/2026 13:37'
}
SRGun >> collisionGeometry [

	^ SRCollisionBox new
		center: (self globalTransform localPointToGlobal: 0 @ -2.5cm @ -6cm);
		size: 4cm @ 15cm @ 25cm;
		rotation: self globalRotation;
		object: self
]

{
	#category : #collisions,
	#'squeak_changestamp' : 'MCPServer (leo) 10/29/2026 13:37'
}
SRGun >> dragTo: aMatrix4x4 [
	"Instead of keeping the offset from where the hand grabbed us, snap into the hand so that the barrel follows the hand's aim."

	self isHeld ifFalse: [^ super dragTo: aMatrix4x4].
	
	self globalTransform: hand globalTransform * self holdTransform * self recoilTransform.
]

{
	#category : #actions,
	#'squeak_changestamp' : 'MCPServer (leo) 10/29/2026 13:37'
}
SRGun >> fire [

	cooldown := self class fireInterval.
	recoil := 1.
	muzzleFlash flash.
	self spawnBullet.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer (leo) 10/29/2026 13:37'
}
SRGun >> hand [

	^ hand
]

{
	#category : #transforms,
	#'squeak_changestamp' : 'MCPServer (leo) 10/29/2026 13:37'
}
SRGun >> holdTransform [
	"lines the barrel up with the hand's aim ray"

	^ Matrix4x4 withOffset: 0 @ self muzzleOffset y negated @ 2cm
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'MCPServer (leo) 10/29/2026 13:37'
}
SRGun >> initialize [

	super initialize.
	
	recoil := 0.
	cooldown := 0.
	
	self buildModel.
	muzzleFlash := SRGunMuzzleFlash new
		translation: self muzzleOffset;
		yourself.
	self addChild: muzzleFlash.
]

{
	#category : #testing,
	#'squeak_changestamp' : 'MCPServer (leo) 10/29/2026 13:37'
}
SRGun >> isHeld [

	^ hand notNil and: [hand grabbedObject == self]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer (leo) 10/29/2026 13:37'
}
SRGun >> muzzleOffset [

	^ 0 @ 1.6cm @ -18cm
]

{
	#category : #events,
	#'squeak_changestamp' : 'MCPServer (leo) 10/29/2026 13:37'
}
SRGun >> onGrabStarted: aHand [

	hand := aHand.
	recoil := 0.
]

{
	#category : #events,
	#'squeak_changestamp' : 'MCPServer (leo) 10/29/2026 13:37'
}
SRGun >> onGrabStopped: aHand [

	hand == aHand ifTrue: [hand := nil].
	recoil := 0.
]

{
	#category : #transforms,
	#'squeak_changestamp' : 'MCPServer (leo) 10/29/2026 13:37'
}
SRGun >> recoilTransform [
	"kicks the gun back and tips the muzzle up, pivoting around the grip"

	recoil <= 0 ifTrue: [^ Matrix4x4 identity].
	
	^ (Matrix4x4 withOffset: 0 @ (0.8cm * recoil) @ (self class recoilKickback * recoil))
		* (Matrix4x4 withRotation: self class recoilAngle * recoil around: Vector3 right)
]

{
	#category : #actions,
	#'squeak_changestamp' : 'MCPServer (leo) 10/29/2026 13:37'
}
SRGun >> spawnBullet [

	| bullet transform |
	self world ifNil: [^ self].
	
	transform := muzzleFlash globalTransform copy.
	bullet := SRGunBullet new
		velocity: muzzleFlash forward * self class bulletSpeed;
		yourself.
	self world addChild: bullet.
	bullet globalTransform: transform.
]

{
	#category : #stepping,
	#'squeak_changestamp' : 'MCPServer (leo) 10/29/2026 13:37'
}
SRGun >> step: deltaTime [

	cooldown := cooldown - deltaTime max: 0.
	recoil > 0 ifTrue: [
		recoil := recoil * (0.5 raisedTo: deltaTime / self class recoilHalfLife).
		recoil < 0.01 ifTrue: [recoil := 0]].
	
	self isHeld ifFalse: [
		hand := nil.
		^ self].
	
	(hand trigger isJustPressed and: [cooldown = 0]) ifTrue: [self fire].
]
