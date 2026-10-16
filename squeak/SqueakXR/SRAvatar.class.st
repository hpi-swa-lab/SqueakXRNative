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
		'blinkOverlay'
	],
	#classVars : [
		'LocomotionStyle',
		'SmoothTurnSpeed',
		'SnapTurnAngle',
		'TeleportBlink',
		'TurnStyle'
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
	#category : #accessing,
	#'squeak_changestamp' : 'lege 10/8/2025 17:50'
}
SRAvatar >> rightHand [

	^ rightHand
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
