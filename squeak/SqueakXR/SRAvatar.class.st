Class {
	#name : #SRAvatar,
	#superclass : #SRObject,
	#instVars : [
		'camera',
		'leftHand',
		'rightHand',
		'contextMenu',
		'ghostAvatar',
		'teleportPreview',
		'blinkOverlay',
		'body',
		'locomotionEnabled',
		'lastRigTranslation'
	],
	#classVars : [
		'LocomotionStyle',
		'SmoothTurnSpeed',
		'SnapTurnAngle',
		'TeleportBlink',
		'TurnStyle',
		'WalkSpeed'
	],
	#category : #'SqueakXR-Objects'
}

{
	#category : #preferences,
	#'squeak_changestamp' : 'MCPServer 10/16/2026 15:16'
}
SRAvatar class >> locomotionStyle [
	<preference: 'Locomotion style'
		category: 'SqueakXR'
		description: 'What the left thumbstick does: #teleport aims an arc and goes on release, #continuous walks.'
		type: #Symbol>
	^ LocomotionStyle ifNil: [#teleport]
]

{
	#category : #preferences,
	#'squeak_changestamp' : 'MCPServer 10/16/2026 15:16'
}
SRAvatar class >> locomotionStyle: aSymbol [
	LocomotionStyle := aSymbol
]

{
	#category : #preferences,
	#'squeak_changestamp' : 'MCPServer 10/16/2026 15:16'
}
SRAvatar class >> locomotionStyleChoices [
	^ #(#teleport #continuous)
]

{
	#category : #constants,
	#'squeak_changestamp' : 'MCPServer 8/10/2026 13:54'
}
SRAvatar class >> menuSpawnDistance [
	^ 20cm
]

{
	#category : #constants,
	#'squeak_changestamp' : 'MCPServer 8/10/2026 13:54'
}
SRAvatar class >> menuSpawnLift [
	^ 20cm
]

{
	#category : #preferences,
	#'squeak_changestamp' : 'MCPServer 10/16/2026 15:17'
}
SRAvatar class >> smoothTurnSpeed [
	<preference: 'Smooth turn speed'
		category: 'SqueakXR'
		description: 'Degrees per second at full stick deflection, when the turn style is #smooth.'
		type: #Number>
	^ SmoothTurnSpeed ifNil: [120]
]

{
	#category : #preferences,
	#'squeak_changestamp' : 'MCPServer 10/16/2026 15:17'
}
SRAvatar class >> smoothTurnSpeed: aNumber [
	SmoothTurnSpeed := aNumber
]

{
	#category : #preferences,
	#'squeak_changestamp' : 'MCPServer 10/16/2026 15:17'
}
SRAvatar class >> snapTurnAngle [
	<preference: 'Snap turn angle'
		category: 'SqueakXR'
		description: 'Degrees per snap turn.'
		type: #Number>
	^ SnapTurnAngle ifNil: [45]
]

{
	#category : #preferences,
	#'squeak_changestamp' : 'MCPServer 10/16/2026 15:17'
}
SRAvatar class >> snapTurnAngle: aNumber [
	SnapTurnAngle := aNumber
]

{
	#category : #preferences,
	#'squeak_changestamp' : 'MCPServer 10/16/2026 15:57'
}
SRAvatar class >> teleportBlink [
	<preference: 'Teleport blink'
		category: 'SqueakXR'
		description: 'Fade to black over the moment of arrival. Moving the world under an open eye is the part that makes people sick.'
		type: #Boolean>
	^ TeleportBlink ifNil: [true]
]

{
	#category : #preferences,
	#'squeak_changestamp' : 'MCPServer 10/16/2026 15:57'
}
SRAvatar class >> teleportBlink: aBoolean [
	TeleportBlink := aBoolean
]

{
	#category : #preferences,
	#'squeak_changestamp' : 'MCPServer 10/16/2026 15:17'
}
SRAvatar class >> turnStyle [
	<preference: 'Turn style'
		category: 'SqueakXR'
		description: 'What the right thumbstick does: #snap jumps by a fixed angle, #smooth rotates continuously and makes most people sick.'
		type: #Symbol>
	^ TurnStyle ifNil: [#snap]
]

{
	#category : #preferences,
	#'squeak_changestamp' : 'MCPServer 10/16/2026 15:17'
}
SRAvatar class >> turnStyle: aSymbol [
	TurnStyle := aSymbol
]

{
	#category : #preferences,
	#'squeak_changestamp' : 'MCPServer 10/16/2026 15:17'
}
SRAvatar class >> turnStyleChoices [
	^ #(#snap #smooth)
]

{
	#category : #preferences,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/19/2026 14:45'
}
SRAvatar class >> walkSpeed [
	<preference: 'Walk speed'
		category: 'SqueakXR'
		description: 'Metres per second the left thumbstick walks in continuous locomotion. A brisk walk: faster reads as sliding, and sliding is what makes stick locomotion sickening.'
		type: #Number>
	^ WalkSpeed ifNil: [1.5]
]

{
	#category : #preferences,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/19/2026 14:45'
}
SRAvatar class >> walkSpeed: metresPerSecond [

	WalkSpeed := metresPerSecond
]

{
	#category : #'xr menu',
	#'squeak_changestamp' : 'MCPServer 8/3/2026 14:38'
}
SRAvatar class >> xrMenuOutOfBodyLabel: aMenu [
	^ aMenu world avatar isOutOfBody
		ifTrue: ['Return to Body']
		ifFalse: ['Out-of-Body Mode']
]

{
	#category : #'xr menu',
	#'squeak_changestamp' : 'MCPServer 8/3/2026 14:38'
}
SRAvatar class >> xrMenuToggleOutOfBody: aMenu [
	<xrMenu: #(world debug) label: #xrMenuOutOfBodyLabel: priority: 410>
	^ aMenu world avatar toggleOutOfBody
]

{
	#category : #locomotion,
	#'squeak_changestamp' : 'MCPServer 10/16/2026 15:42'
}
SRAvatar >> aimTeleportFrom: aHand [
	| arc |
	self world ifNil: [^ self].
	arc := SRBallisticArc new
		origin: aHand globalTranslation direction: aHand backward;
		castIn: self world;
		yourself.
	self teleportPreview showArc: arc
]

{
	#category : #locomotion,
	#'squeak_changestamp' : 'MCPServer 10/16/2026 15:57'
}
SRAvatar >> blinkOverlay [
	"A child of the camera, so it stays in front of the face however the head
	moves during the blink."

	^ blinkOverlay ifNil: [
		blinkOverlay := SRBlinkOverlay new.
		camera addChild: blinkOverlay.
		blinkOverlay]
]

{
	#category : #locomotion,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/19/2026 14:45'
}
SRAvatar >> body [

	^ body ifNil: [body := SRAvatarBody new]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 10/8/2025 17:49'
}
SRAvatar >> camera [

	^ camera
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 3/19/2026 14:50'
}
SRAvatar >> cameraPosition: position target: target up: up [

	camera globalTransform: (Matrix4x4 objectLookAt: target from: position up: up) 
]

{
	#category : #locomotion,
	#'squeak_changestamp' : 'MCPServer 10/16/2026 15:42'
}
SRAvatar >> cancelTeleportAim [
	teleportPreview ifNotNil: [:preview | preview hide]
]

{
	#category : #locomotion,
	#'squeak_changestamp' : 'MCPServer 10/16/2026 15:57'
}
SRAvatar >> commitTeleport [
	"Runs on the frame the stick returns to centre. The preview being hidden is
	what says no aim was in progress, so this is cheap on every other frame."

	teleportPreview ifNil: [^ self].
	teleportPreview visible ifFalse: [^ self].
	teleportPreview landingPoint ifNotNil: [:point |
		self class teleportBlink
			ifTrue: [self blinkOverlay blinkThen: [self teleportTo: point]]
			ifFalse: [self teleportTo: point]].
	teleportPreview hide
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 6/30/2026 17:09'
}
SRAvatar >> contextMenu [

	^ contextMenu
]

{
	#category : #'out-of-body',
	#'squeak_changestamp' : 'lege 7/20/2026 17:47'
}
SRAvatar >> enterOutOfBody [

	self assert: ghostAvatar isNil.
	
	ghostAvatar := SRGhostAvatar new referenceAvatar: self.
	self world addChild: ghostAvatar.
]

{
	#category : #'out-of-body',
	#'squeak_changestamp' : 'lege 7/20/2026 17:49'
}
SRAvatar >> exitOutOfBody [

	ghostAvatar ifNil: [^ self].
	
	ghostAvatar remove.
	ghostAvatar := nil.
]

{
	#category : #events,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 15:50'
}
SRAvatar >> forget: anSRObject [
	contextMenu == anSRObject ifTrue: [contextMenu := nil].
	self hands do: [:each | each ifNotNil: [each forget: anSRObject]].
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 7/3/2026 17:26'
}
SRAvatar >> hands [

	^ {self leftHand. self rightHand}
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'lege 7/21/2026 18:10'
}
SRAvatar >> initialize [

	super initialize.
	
	leftHand := SRHand left avatar: self.
	rightHand := SRHand right avatar: self.
	camera := SRAvatarCamera new.

	self addChildren: {leftHand. rightHand. camera}.
]

{
	#category : #'out-of-body',
	#'squeak_changestamp' : 'lege 7/20/2026 17:50'
}
SRAvatar >> isOutOfBody [

	^ ghostAvatar notNil
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 10/8/2025 17:50'
}
SRAvatar >> leftHand [

	^ leftHand
]

{
	#category : #locomotion,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/19/2026 14:45'
}
SRAvatar >> locomotionEnabled [

	^ locomotionEnabled == true
]

{
	#category : #locomotion,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/19/2026 14:45'
}
SRAvatar >> locomotionEnabled: aBoolean [
	"Off by default: a flying camera over a scene must not be dragged to the floor
	by gravity. An application that means the player to stand in its world turns
	it on, as SWAGameXR does when it scales a block to a metre."

	locomotionEnabled := aBoolean.
	aBoolean ifTrue: [lastRigTranslation := nil].
]

{
	#category : #menu,
	#'squeak_changestamp' : 'MCPServer 8/3/2026 14:38'
}
SRAvatar >> menuPlacementPositionForHand: aHand [
	"Orientation comes from the camera, see SRMenu>>setTransformAt:facingCamera:."

	^ aHand globalTranslation
		+ (camera forward * self class menuSpawnDistance)
		+ (Vector3 up * self class menuSpawnLift)
]

{
	#category : #menu,
	#'squeak_changestamp' : 'MCPServer 8/3/2026 13:48'
}
SRAvatar >> openContextMenuFor: anObject at: aPosition [

	^ contextMenu := SRMenu
		contextMenuFor: anObject
		at: aPosition
		facingCamera: self camera
		in: self world
]

{
	#category : #menu,
	#'squeak_changestamp' : 'lege 7/2/2026 11:35'
}
SRAvatar >> openMenuForHand: aHand [
	"Notified by a hand that a menu should be spawned. If our menu is still open,
	close it. Otherwise open a context menu for the hand's grabbed object, or the
	world menu. A menu that was dismissed elsewhere (e.g. by selecting an item)
	has a nil parent, so it no longer counts as open."

	| position |
	(contextMenu notNil and: [contextMenu isOpen]) ifTrue: [
		contextMenu remove.
		contextMenu := nil.
		^ self].
	position := self menuPlacementPositionForHand: aHand.
	aHand grabbedObject
		ifNotNil: [:object | self openContextMenuFor: object at: position]
		ifNil: [self openWorldMenuAt: position].
]

{
	#category : #menu,
	#'squeak_changestamp' : 'MCPServer 8/3/2026 13:48'
}
SRAvatar >> openWorldMenuAt: aPosition [

	^ contextMenu := SRMenu
		worldMenuAt: aPosition
		facingCamera: self camera
		in: self world
]

{
	#category : #locomotion,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/19/2026 14:45'
}
SRAvatar >> rigWasMovedExternally [
	"We are the only writer of the rig's translation while locomotion is on, so any
	value other than the one we left is a teleport -- by a hand, by an application
	placing the player, or from a workspace."

	lastRigTranslation ifNil: [^ true].
	^ (self translation - lastRigTranslation) length > 0.0001
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 10/8/2025 17:50'
}
SRAvatar >> rightHand [

	^ rightHand
]

{
	#category : #locomotion,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/19/2026 14:45'
}
SRAvatar >> snapBodyUnderHead: head floorY: feetY [
	"Stand the collision body where the rig was just put, without walking it there.
	The body lags one teleport behind otherwise, and the correction then drags the
	player across the whole gap at walking speed, which is the one thing teleport
	exists to avoid."

	self body restAt: (Vector3 x: head x y: feetY z: head z).
]

{
	#category : #locomotion,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/19/2026 14:45'
}
SRAvatar >> stickMotionFor: aHand dt: dt [
	"How far the stick asks to travel this frame, in metres. A standing player
	cannot room-scale across a landscape, so the stick has to carry them.

	Camera relative and flattened to the horizontal plane: pushing forward goes
	where you look rather than where the controller points, and looking up does
	not launch you."

	| stick forward right flat |
	self stickWalksThePlayer ifFalse: [^ nil].
	aHand ifNil: [^ nil].
	camera ifNil: [^ nil].
	stick := aHand inputState joystick vector.
	(stick x = 0 and: [stick y = 0]) ifTrue: [^ nil].
	flat := [:v |
		| horizontal |
		horizontal := Vector3 x: v x y: 0 z: v z.
		horizontal length < 0.001 ifTrue: [nil] ifFalse: [horizontal normalized]].
	forward := flat value: camera forward.
	right := flat value: camera right.
	(forward isNil or: [right isNil]) ifTrue: [^ nil].
	^ ((forward * stick y) + (right * stick x)) * (self class walkSpeed * dt)
]

{
	#category : #locomotion,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/19/2026 14:45'
}
SRAvatar >> stickWalksThePlayer [
	"The same stick aims the teleport arc in the other style, so it cannot also
	walk: the player would move while choosing where to go."

	^ self class locomotionStyle == #continuous
]

{
	#category : #locomotion,
	#'squeak_changestamp' : 'MCPServer 10/16/2026 15:41'
}
SRAvatar >> teleportPreview [
	"A child of the world, not of the rig: it marks a place on the ground, and a
	child of the rig would be carried along by the teleport it is previewing."

	^ teleportPreview ifNil: [
		teleportPreview := SRTeleportPreview new.
		self world ifNotNil: [:w | w addChild: teleportPreview].
		teleportPreview]
]

{
	#category : #locomotion,
	#'squeak_changestamp' : 'MCPServer 10/16/2026 14:57'
}
SRAvatar >> teleportTo: aGlobalPoint [
	"Put the player's feet on the target, not the rig origin. The head stands
	anywhere inside the play space -- metres away after walking about -- so
	moving the rig origin to the target lands the player that far off their aim,
	and drops them if the ground there is lower.

	In STAGE space the floor is the rig's own y plane, which is what makes the
	feet readable at all."

	| head feet |
	head := self camera globalTranslation.
	feet := head x @ self globalTranslation y @ head z.
	self translation: self translation + (aGlobalPoint - feet)
]

{
	#category : #'out-of-body',
	#'squeak_changestamp' : 'lege 7/20/2026 17:50'
}
SRAvatar >> toggleOutOfBody [

	self isOutOfBody
		ifTrue: [self exitOutOfBody]
		ifFalse: [self enterOutOfBody]
]

{
	#category : #locomotion,
	#'squeak_changestamp' : 'MCPServer 10/16/2026 15:49'
}
SRAvatar >> turnBy: degrees [
	"About the player's own vertical axis, not the rig origin. The head is
	metres from the origin after walking the play space, and turning about the
	origin would swing the player sideways through the room instead of letting
	them look the other way."

	| spin pivot offset |
	degrees = 0 ifTrue: [^ self].
	spin := Quaternion angle: degrees axis: Vector3 up.
	pivot := camera globalTranslation.
	offset := self translation - (pivot x @ self translation y @ pivot z).
	self
		translation: (pivot x @ self translation y @ pivot z) + (spin rotateVector: offset);
		rotation: spin * self rotation
]

{
	#category : #locomotion,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/19/2026 14:45'
}
SRAvatar >> updateLocomotion: deltaTime [
	"The player is moved by the headset and by the stick, and neither knows what is
	solid. Read where they went, resolve it against the scene, and write the
	difference back to the rig, which is the only part of the player we may move.

	deltaTime is milliseconds, and it is the frame delta rather than any fixed
	tick: walking must not inherit a simulation's period."

	| dt head feetY correction |
	self locomotionEnabled ifFalse: [^ self].
	camera ifNil: [^ self].
	"A frame long enough to tunnel through a wall is better slowed than skipped."
	dt := (deltaTime asFloat / 1000.0) min: 0.1.
	dt <= 0.0 ifTrue: [^ self].
	"The head, not the rig: on the desktop SRSimpleAvatarMovementEmulator moves the
	camera inside the rig and in XR the headset does, so the rig never moves on its
	own and reading it would see no walking at all."
	head := camera globalTranslation.
	"OpenXR poses arrive in STAGE space, so the rig's own y is the physical floor.
	Subtracting a body height from the head instead makes ducking look like the
	ground rising to meet you."
	feetY := self globalTranslation y.
	self rigWasMovedExternally
		ifTrue: [self snapBodyUnderHead: head floorY: feetY].
	correction := self
		walkCorrectionForHead: head
		floorY: feetY
		stickMotion: (self stickMotionFor: leftHand dt: dt)
		dt: dt.
	self translation: self translation + correction.
	lastRigTranslation := self translation.
]

{
	#category : #locomotion,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/19/2026 15:48'
}
SRAvatar >> walkCorrectionForHead: head floorY: feetY stickMotion: motionOrNil dt: dt [
	"How far the rig has to move for the player to stand where the scene allows.
	Separate from #updateLocomotion: so it can be exercised without a camera."

	| feet solids |
	feet := Vector3 x: head x y: feetY z: head z.
	"Collected once: resolving a step costs a dozen queries, and walking the graph
	building a geometry object per collider measures 1.7 ms on a 234-object world."
	solids := SRSceneSolids forObject: self.
	self body height: head y - feetY.
	"A step taken on the real floor cannot be refused. Pushing back against the
	head moves the world out from under the player rather than stopping them,
	which is both sickening and a lie about where they are standing.

	The head alone: this asked whether the whole body box was clear, so standing on
	a floor at all could answer no and freeze every frame."
	(self body headInSolidAt: head in: solids) ifTrue: [^ Vector3 zero].
	self body feetAtX: head x z: head z.
	"Only the stick is resolved against the scene, because only the stick can be
	refused: it is the one movement the player did not actually make."
	motionOrNil
		ifNil: [self body velocityX: 0.0 z: 0.0]
		ifNotNil: [:motion | self body velocityX: motion x / dt z: motion z / dt].
	self body applyPhysicsIn: solids dt: dt.
	^ self body position - feet
]
