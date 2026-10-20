"
Stands in for a headset and a left controller on the desktop.

Moves the avatar, never the camera: WASD is a request to move the player, the same as a thumbstick, while a camera that moved on its own would be claiming the head had physically moved.
"
Class {
	#name : #SRSimpleAvatarMovementEmulator,
	#superclass : #Object,
	#instVars : [
		'yaw',
		'pitch',
		'moveSpeed',
		'lookSpeed',
		'lookModeEnabled',
		'avatar',
		'isUpdatingEnabled'
	],
	#category : #'SqueakXR-Objects',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/20/2026 15:09'
}
SRSimpleAvatarMovementEmulator >> avatar: anAvatar [
	"Stand the player back from the origin, where the scene is, unless something
	has already placed them. The rig carries this now; it used to be an offset
	baked into the camera, which made flat and XR disagree by 2.5 m."

	avatar := anAvatar.
	(avatar notNil and: [avatar translation = Vector3 zero]) ifTrue: [
		avatar translation: 0m @ 0m @ 2.5m].
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/20/2026 15:09'
}
SRSimpleAvatarMovementEmulator >> cameraTransform [

	| forward eye |
	forward := self forwardVector.
	eye := self position + (0 @ self eyeHeight @ 0).
	^ Matrix4x4 objectLookAt: eye + forward from: eye up: Vector3 up
]

{
	#category : #movement,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/20/2026 17:13'
}
SRSimpleAvatarMovementEmulator >> driveStickStrafe: strafe advance: advance [
	"Raw axes, unrotated: SRAvatar>>stickMotionFor:dt: resolves the stick against
	the camera itself, so rotating here would apply the heading twice."

	"Negated: SRAvatar>>stickMotionFor:dt: resolves the stick against #camera
	right, which is the exact opposite of the #forward cross: up this class uses
	to fly -- measured dot -1.0. Without this, A and D swap when walk mode is
	switched on."
	avatar leftHand ifNotNil: [:hand |
		hand inputState joystick
			horizontal: strafe negated;
			vertical: advance].
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/20/2026 15:08'
}
SRSimpleAvatarMovementEmulator >> eyeHeight [
	"A headset reports where the head is; the desktop has to pick a height."

	^ 1.8m
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MCPServer 5/13/2026 13:57'
}
SRSimpleAvatarMovementEmulator >> forwardVector [

	| yawRad pitchRad |
	yawRad := yaw degreesToRadians.
	pitchRad := pitch degreesToRadians.
	^ (pitchRad cos * yawRad cos @ pitchRad sin @ (pitchRad cos * yawRad sin)) normalize
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MCPServer 5/13/2026 13:58'
}
SRSimpleAvatarMovementEmulator >> handleMouseDelta: aDelta [

	yaw := yaw + (aDelta x * lookSpeed).
	pitch := (pitch - (aDelta y * lookSpeed)) min: 89.0 max: -89.0
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/20/2026 15:09'
}
SRSimpleAvatarMovementEmulator >> initialize [

	super initialize.
	"Looking down -Z at the origin: that is the frame SWAGameXR's slabs and
	raylib's 3D text are laid out in, and the OpenXR head convention."
	yaw := -90.0.
	pitch := -25.0.
	moveSpeed := 3m.
	lookSpeed := 0.15.
	lookModeEnabled := false.
	isUpdatingEnabled := true.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 5/13/2026 13:58'
}
SRSimpleAvatarMovementEmulator >> lookModeEnabled [

	^ lookModeEnabled
]

{
	#category : #movement,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/20/2026 15:08'
}
SRSimpleAvatarMovementEmulator >> moveStrafe: strafe advance: advance lift: lift deltaSeconds: dt [
	"WASD asks the player to move, so it moves the rig -- never the camera.
	With locomotion on, the request goes to the left stick and the avatar's own
	walker resolves it against the scene; otherwise it is a free fly."

	| forward right movement |
	avatar ifNil: [^ self].
	avatar locomotionEnabled ifTrue: [
		^ self driveStickStrafe: strafe advance: advance].
	forward := yaw degreesToRadians cos @ 0 @ yaw degreesToRadians sin.
	right := (forward cross: Vector3 up) normalize.
	movement := (forward * advance) + (right * strafe) + (Vector3 up * lift).
	movement length > 0 ifTrue: [
		avatar translation: avatar translation + (movement normalize * moveSpeed * dt)].
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/20/2026 15:09'
}
SRSimpleAvatarMovementEmulator >> position [

	"The rig, which is where the player is. The head sits #eyeHeight above it."

	^ avatar ifNil: [Vector3 zero] ifNotNil: [:a | a translation]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/20/2026 15:09'
}
SRSimpleAvatarMovementEmulator >> position: aVector3 [
	avatar ifNotNil: [:a | a translation: aVector3].
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MCPServer 5/13/2026 13:58'
}
SRSimpleAvatarMovementEmulator >> toggleLookMode [

	lookModeEnabled := lookModeEnabled not.
	Transcript cr; show: 'Camera look mode: ',
		(lookModeEnabled ifTrue: ['ON'] ifFalse: ['OFF']).
	^ lookModeEnabled
]

{
	#category : #actions,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/20/2026 15:08'
}
SRSimpleAvatarMovementEmulator >> update: deltaMillis [
	| input deltaSeconds held |
	input := SRDesktopInputState current.
	(input isKeyPressed: RlKeyboardKey keyGrave) ifTrue: [
		isUpdatingEnabled := isUpdatingEnabled not].
	isUpdatingEnabled ifFalse: [^ self].
	
	deltaSeconds := deltaMillis / 1000.0.
	held := [:key | (input isKeyDown: key) ifTrue: [1] ifFalse: [0]].
	self
		moveStrafe: (held value: RlKeyboardKey keyD) - (held value: RlKeyboardKey keyA)
		advance: (held value: RlKeyboardKey keyW) - (held value: RlKeyboardKey keyS)
		lift: (held value: RlKeyboardKey keyLeftShift) - (held value: RlKeyboardKey keyLeftControl)
		deltaSeconds: deltaSeconds.
	lookModeEnabled ifTrue: [
		self handleMouseDelta: input mouseDelta].
	self updateAvatarCamera
]

{
	#category : #updating,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/20/2026 15:08'
}
SRSimpleAvatarMovementEmulator >> updateAvatarCamera [

	"Orientation and eye height only. The camera is the head, and on the desktop
	the head does not wander off the rig: WASD is a request to move the player,
	so it moves the avatar (see journal 2026-10-20)."

	| forward eye |
	avatar ifNil: [^ self].
	eye := 0 @ self eyeHeight @ 0.
	forward := self forwardVector.
	avatar cameraLocalPosition: eye target: eye + forward up: Vector3 up
]
