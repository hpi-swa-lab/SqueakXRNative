"
The player: a rig carrying the camera and both hands.

Moving the avatar moves the player; the camera is where their head is, which in XR the headset sets and on the desktop SRSimpleAvatarMovementEmulator does.
"
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
		'lastRigTranslation',
		'trackedHands'
	],
	#classVars : [
		'ContinuousLocomotion',
		'SmoothTurn',
		'SmoothTurnSpeed',
		'SnapTurnAngle',
		'TeleportBlink',
		'WalkSpeed'
	],
	#category : #'SqueakXR-Objects',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #preferences,
	#'squeak_changestamp' : 'MCPServer (MCPServer (MCPServer)) 10/20/2026 16:41'
}
SRAvatar class >> continuousLocomotion [
	<preference: 'Continuous locomotion'
		category: 'SqueakXR'
		description: 'The left thumbstick walks instead of aiming a teleport arc that goes on release.'
		type: #Boolean>
	^ ContinuousLocomotion ifNil: [false]
]

{
	#category : #preferences,
	#'squeak_changestamp' : 'MCPServer (MCPServer (MCPServer)) 10/20/2026 16:41'
}
SRAvatar class >> continuousLocomotion: aBoolean [

	ContinuousLocomotion := aBoolean.
]

{
	#category : #preferences,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 14:58'
}
SRAvatar class >> locomotionStyle [

	^ self continuousLocomotion ifTrue: [#continuous] ifFalse: [#teleport]
]

{
	#category : #preferences,
	#'squeak_changestamp' : 'MCPServer (MCPServer (MCPServer)) 10/20/2026 16:41'
}
SRAvatar class >> locomotionStyle: aSymbol [

	ContinuousLocomotion := aSymbol == #continuous.
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
	#'squeak_changestamp' : 'MCPServer (MCPServer (MCPServer)) 10/20/2026 16:41'
}
SRAvatar class >> smoothTurn [
	<preference: 'Smooth turn'
		category: 'SqueakXR'
		description: 'The right thumbstick rotates continuously instead of jumping by a fixed angle. Smooth turning makes most people sick.'
		type: #Boolean>
	^ SmoothTurn ifNil: [false]
]

{
	#category : #preferences,
	#'squeak_changestamp' : 'MCPServer (MCPServer (MCPServer)) 10/20/2026 16:41'
}
SRAvatar class >> smoothTurn: aBoolean [

	SmoothTurn := aBoolean.
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
	#'squeak_changestamp' : 'leo 10/29/2026 16:29'
}
SRAvatar class >> snapTurnAngle [
	<preference: 'Snap turn angle' category: 'SqueakXR' description: 'Degrees per snap turn.' type: #Number>
	^ SnapTurnAngle
		ifNil: [-45]
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
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 15:01'
}
SRAvatar class >> turnStyle [
	"A Boolean preference rather than a Symbol one: the Preference Browser has no view for 
	#Symbol, and one unsupported type takes the whole browser down."
	^ self smoothTurn ifTrue: [#smooth] ifFalse: [#snap]

]

{
	#category : #preferences,
	#'squeak_changestamp' : 'MCPServer (MCPServer (MCPServer)) 10/20/2026 16:41'
}
SRAvatar class >> turnStyle: aSymbol [

	SmoothTurn := aSymbol == #smooth.
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
	#'squeak_changestamp' : 'MCPServer (jl) 10/21/2026 09:54'
}
SRAvatar >> aimTeleportFrom: aHand [
	| arc |
	self world ifNil: [^ self].
	arc := SRBallisticArc new
		origin: aHand globalTranslation direction: aHand forward;
		castIn: self world;
		yourself.
	self teleportPreview showArc: arc
]

{
	#category : #locomotion,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 14:58'
}
SRAvatar >> blinkOverlay [

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
	#category : #camera,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 14:58'
}
SRAvatar >> cameraLocalPosition: aPosition target: aTarget up: up [

	camera localTransform: (Matrix4x4 objectLookAt: aTarget from: aPosition up: up).
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
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 14:58'
}
SRAvatar >> commitTeleport [

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
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:04'
}
SRAvatar >> enableHandTracking [

	trackedHands := {SRTrackedHand left. SRTrackedHand right}.
	self addChildren: trackedHands.
	^ trackedHands
]

{
	#category : #'out-of-body',
	#'squeak_changestamp' : 'MCPServer (jl) 10/21/2026 11:48'
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
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/20/2026 18:04'
}
SRAvatar >> ghostAvatar [

	^ ghostAvatar
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
	#'squeak_changestamp' : 'MCPServer (leo) 10/29/2026 17:56'
}
SRAvatar >> initialize [

	super initialize.
	
	leftHand := SRHand left avatar: self.
	rightHand := SRHand right avatar: self.
	camera := SRAvatarCamera new.

	self addChildren: {leftHand. rightHand. camera}.
	camera addChild: SRSkyBox new.
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
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 14:58'
}
SRAvatar >> locomotionEnabled: aBoolean [

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
	#category : #menus,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/20/2026 10:44'
}
SRAvatar >> openAppMenuFor: anApp at: aPosition [

	^ contextMenu := SRMenu
		appMenuFor: anApp
		at: aPosition
		facingCamera: self camera
		in: self world
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
	#'squeak_changestamp' : 'MCPServer (jl) 10/29/2026 12:57'
}
SRAvatar >> openMenuForHand: aHand [

	| position |
	(contextMenu notNil and: [contextMenu isOpen]) ifTrue: [
		contextMenu remove.
		contextMenu := nil.
		^ self].
	position := self menuPlacementPositionForHand: aHand.
	aHand grabbedObject ifNotNil: [:object | ^ self openContextMenuFor: object at: position].
	aHand appUnderRay
		ifNil: [self openWorldMenuAt: position]
		ifNotNil: [:app | self openAppMenuFor: app at: position].
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
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 14:58'
}
SRAvatar >> restDeadband [

	^ 1 mm
]

{
	#category : #locomotion,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 14:58'
}
SRAvatar >> rigWasMovedExternally [

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
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 14:58'
}
SRAvatar >> snapBodyUnderHead: head floorY: feetY [

	self body restAt: (Vector3 x: head x y: feetY z: head z).
]

{
	#category : #locomotion,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 14:58'
}
SRAvatar >> stickMotionFor: aHand dt: dt [

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
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 14:58'
}
SRAvatar >> stickWalksThePlayer [

	^ self class locomotionStyle == #continuous
]

{
	#category : #locomotion,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 14:58'
}
SRAvatar >> teleportPreview [

	^ teleportPreview ifNil: [
		teleportPreview := SRTeleportPreview new.
		self world ifNotNil: [:w | w addChild: teleportPreview].
		teleportPreview]
]

{
	#category : #locomotion,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 14:58'
}
SRAvatar >> teleportTo: aGlobalPoint [

	| head feet delta |
	head := self camera globalTranslation.
	feet := head x @ self globalTranslation y @ head z.
	delta := aGlobalPoint - feet.

	self travellers do: [:each |
		each globalTranslation: each globalTranslation + delta].
	self translation: self translation + delta
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
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 14:58'
}
SRAvatar >> travellers [

	| found |
	found := OrderedCollection new.
	self sceneRoot allDo: [:each |
		(each travelsWithAvatar
			and: [(each isWithin: self) not
			and: [found noneSatisfy: [:outer | each isWithin: outer]]])
				ifTrue: [found add: each]].
	^ found
]

{
	#category : #locomotion,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 14:58'
}
SRAvatar >> turnBy: degrees [

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
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 14:58'
}
SRAvatar >> updateLocomotion: deltaTime [

	| dt head feetY correction |
	self locomotionEnabled ifFalse: [^ self].
	camera ifNil: [^ self].

	dt := (deltaTime asFloat / 1000.0) min: 0.1.
	dt <= 0.0 ifTrue: [^ self].

	head := camera globalTranslation.

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
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 14:58'
}
SRAvatar >> walkCorrectionForHead: head floorY: feetY stickMotion: motionOrNil dt: dt [

	| feet solids correction |
	feet := Vector3 x: head x y: feetY z: head z.

	solids := SRSceneSolids forObject: self.
	self body height: head y - feetY.

	(self body headInSolidAt: head in: solids) ifTrue: [^ Vector3 zero].
	self body feetAtX: head x z: head z.

	motionOrNil
		ifNil: [self body velocityX: 0.0 z: 0.0]
		ifNotNil: [:motion | self body velocityX: motion x / dt z: motion z / dt].
	self body applyPhysicsIn: solids dt: dt.
	^ self body position - feet
]
