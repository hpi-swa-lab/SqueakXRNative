"
Desktop input emulator for XR interactions in flat mode.
"
Class {
	#name : #SRDesktopInputStrategy,
	#superclass : #SRInputStrategy,
	#instVars : [
		'emulatedCamera',
		'debugHUD',
		'grabRadius',
		'grabBearing',
		'grabHeight',
		'grabTransform',
		'grabEye'
	],
	#category : #'SqueakXR-Objects',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #constants,
	#'squeak_changestamp' : 'MCPServer 8/10/2026 13:56'
}
SRDesktopInputStrategy class >> aimConvergenceDistance [
	"Fallback aim distance when the ray meets nothing."

	^ 5m
]

{
	#category : #constants,
	#'squeak_changestamp' : 'jl 8/10/2026 14:49'
}
SRDesktopInputStrategy class >> handOffset [
	"(right, up, ahead) in a yaw-only head frame. "
	^  34cm @ -57cm @ 47cm
]

{
	#category : #constants,
	#'squeak_changestamp' : 'MCPServer (jl) 11/10/2026 18:34'
}
SRDesktopInputStrategy class >> heldAimOffset [
	"(right, up, ahead) in the full head frame, low right in view like a first-person shooter."

	^ 12cm @ -12cm @ 35cm
]

{
	#category : #constants,
	#'squeak_changestamp' : 'MCPServer 8/10/2026 13:56'
}
SRDesktopInputStrategy class >> leftHandOffset [
	^ self handOffset * (-1 @ 1 @ 1)
]

{
	#category : #constants,
	#'squeak_changestamp' : 'MCPServer 8/3/2026 15:55'
}
SRDesktopInputStrategy class >> rightHandOffset [
	^ self handOffset
]

{
	#category : #menu,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 15:46'
}
SRDesktopInputStrategy class >> xrMenuFullscreenLabel: aMenu [

	^ (aMenu world actingAvatar ifNotNil: [:avatar | avatar renderer isFullscreen] ifNil: [false])
		ifTrue: ['Exit Fullscreen (F11)']
		ifFalse: ['Fullscreen (F11)']
]

{
	#category : #menu,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 15:46'
}
SRDesktopInputStrategy class >> xrMenuToggleFullscreen: aMenu [
	<xrMenu: #(world debug) label: #xrMenuFullscreenLabel: priority: 9000>
	aMenu world actingAvatar ifNotNil: [:avatar | avatar renderer toggleFullscreen]
]

{
	#category : #hands,
	#'squeak_changestamp' : 'jl-MCPServer 11/20/2026 13:42'
}
SRDesktopInputStrategy >> aimHand: aHand from: aPosition at: aTarget [
	| direction |
	direction := aTarget - aPosition.
	direction isZero ifTrue: [^ aHand].
	direction := direction normalized.
	aHand globalTransform: (Matrix4x4
		objectLookAt: aPosition + direction
		from: aPosition
		up: self avatar camera up).
	^ aHand
]

{
	#category : #input,
	#'squeak_changestamp' : 'jl-MCPServer 11/20/2026 13:42'
}
SRDesktopInputStrategy >> aimHeld: anObject with: aHand along: anOrigin direction: aDirection [
	"The barrel meets the eye ray where it hits, so it shoots at what the mouse points at."

	| camera offset hit distance |
	camera := self avatar camera.
	offset := self class heldAimOffset.
	hit := ((SRRay origin: anOrigin forward: aDirection) castAll: self world)
		detect: [:result | result object ~~ anObject and: [(result object hasAncestor: anObject) not]]
		ifNone: [nil].
	distance := hit ifNil: [100m] ifNotNil: [:result | result distance].
	self world children do: [:each |
		(each respondsTo: #aimDistanceFrom:to:) ifTrue: [
			(each aimDistanceFrom: anOrigin to: anOrigin + (aDirection * distance))
				ifNotNil: [:mobDistance | distance := distance min: mobDistance]]].
	^ self
		aimHand: aHand
		from: camera globalTranslation
			+ (camera right * offset x)
			+ (camera up * offset y)
			+ (camera forward * offset z)
		at: anOrigin + (aDirection * distance)
]

{
	#category : #avatar,
	#'squeak_changestamp' : 'leo-MCPServer 11/22/2026 16:35'
}
SRDesktopInputStrategy >> attachTo: anAvatar [

	super attachTo: anAvatar.
	emulatedCamera avatar: anAvatar.
	debugHUD avatar: anAvatar.
	anAvatar addChild: debugHUD.
]

{
	#category : #input,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 15:00'
}
SRDesktopInputStrategy >> bearingFrom: anEye to: aPoint [

	| d |
	d := aPoint - anEye.
	^ (d x arcTan: d z) radiansToDegrees
]

{
	#category : #input,
	#'squeak_changestamp' : 'MCPServer (jl) 11/16/2026 13:55'
}
SRDesktopInputStrategy >> beginDrag: aMatrix4x4 holding: aPoint from: anEye [

	grabRadius := ((aPoint x - anEye x) squared + (aPoint z - anEye z) squared) sqrt.
	grabBearing := self bearingFrom: anEye to: aPoint.
	grabHeight := aPoint y - anEye y.
	grabEye := anEye.
	grabTransform := aMatrix4x4 copy.
]

{
	#category : #input,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 15:00'
}
SRDesktopInputStrategy >> cylinderHitFrom: anOrigin direction: aDirection eye: anEye radius: aRadius [

	| ox oz dx dz a b c disc |
	ox := anOrigin x - anEye x. oz := anOrigin z - anEye z.
	dx := aDirection x. dz := aDirection z.
	a := (dx * dx) + (dz * dz).
	a < 1.0e-9 ifTrue: [^ nil].
	b := 2.0 * ((ox * dx) + (oz * dz)).
	c := (ox * ox) + (oz * oz) - (aRadius * aRadius).
	disc := (b * b) - (4.0 * a * c).
	disc < 0 ifTrue: [^ nil].
	^ b negated + disc sqrt / (2.0 * a)
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 5/13/2026 13:59'
}
SRDesktopInputStrategy >> debugHUD [

	^ debugHUD
]

{
	#category : #avatar,
	#'squeak_changestamp' : 'leo-MCPServer 11/22/2026 16:35'
}
SRDesktopInputStrategy >> detach [

	debugHUD remove.
	emulatedCamera avatar: nil.
	super detach.
]

{
	#category : #input,
	#'squeak_changestamp' : 'jl-MCPServer 11/20/2026 13:42'
}
SRDesktopInputStrategy >> dragHand: aHand along: anOrigin direction: aDirection [

	| eye t |
	eye := self avatar camera globalTranslation.
	grabRadius ifNil: [
		self beginDrag: aHand globalTransform holding: aHand grabbedObject globalTranslation from: eye].
	t := self
		cylinderHitFrom: anOrigin direction: aDirection eye: eye radius: grabRadius.
	t ifNil: [^ aHand].
	aHand globalTransform: (self dragTransformTo: anOrigin + (aDirection * t) from: eye).
	^ aHand
]

{
	#category : #input,
	#'squeak_changestamp' : 'MCPServer (jl) 11/16/2026 13:55'
}
SRDesktopInputStrategy >> dragTransformTo: aPoint from: anEye [
	"Relative to the eye, so a held object comes along when the avatar walks."

	| lift follow |
	lift := Matrix4x4 withOffset: (Vector3 x: 0 y: aPoint y - anEye y - grabHeight z: 0).
	follow := Matrix4x4 withOffset: anEye - grabEye.
	^ (Matrix4x4
		rotatedBy: (self bearingFrom: anEye to: aPoint) - grabBearing
		around: Vector3 up
		centeredAt: anEye) * (follow * (lift * grabTransform))
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 5/13/2026 13:58'
}
SRDesktopInputStrategy >> emulatedCamera [

	^ emulatedCamera
]

{
	#category : #hands,
	#'squeak_changestamp' : 'jl-MCPServer 11/20/2026 13:42'
}
SRDesktopInputStrategy >> handPositionFor: anOffset [
	"Yaw-only head frame, so the hands stay put when the head pitches."

	| camera ahead right |
	camera := self avatar camera.
	ahead := camera forward.
	ahead := Vector3 x: ahead x y: 0 z: ahead z.
	ahead := ahead isZero ifTrue: [Vector3 forward] ifFalse: [ahead normalized].
	right := Vector3 x: ahead z negated y: 0 z: ahead x.
	^ camera globalTranslation
		+ (right * anOffset x)
		+ (Vector3 up * anOffset y)
		+ (ahead * anOffset z)
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'leo-MCPServer 11/20/2026 19:08'
}
SRDesktopInputStrategy >> initialize [

	super initialize.
	emulatedCamera := SRSimpleAvatarMovementEmulator new.
	debugHUD := SRXRDebugHUD new.
]

{
	#category : #input,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 15:16'
}
SRDesktopInputStrategy >> processDesktopInput: delta [

	| input typing |
	input := SRDesktopInputState current.
	"A panel click sets the focus again during #performActions below."
	((input isMouseButtonPressed: RlMouseButton mouseButtonLeft)
		or: [input isMouseButtonPressed: RlMouseButton mouseButtonMiddle]) ifTrue: [
		self world keyboardFocus: nil].
	typing := self world isTyping.

	(input isKeyPressed: RlKeyboardKey keyF2) ifTrue: [
		debugHUD toggleVisibility].

	(input isKeyPressed: RlKeyboardKey keyF3) ifTrue: [
		self avatar toggleOutOfBody].

	(input isKeyPressed: RlKeyboardKey keyF11) ifTrue: [
		avatar renderer toggleFullscreen].

	(input isKeyPressed: RlKeyboardKey keyKbMenu) ifTrue: [
		SRActingAvatarVariable value: avatar during: [
			avatar openMenuForHand: avatar rightHand]].

	emulatedCamera update: delta.

	(typing not and: [input isKeyPressed: RlKeyboardKey keyTab]) ifTrue: [
		emulatedCamera toggleLookMode].

	self updateLeftHandFromCamera.
	emulatedCamera isLooking
		ifTrue: [self updateRightHandFromScreenCenter]
		ifFalse: [self updateRightHandFromMouseRay].

	self updateHandInput: input.
	self avatar hands do: [:hand |
		hand cursor updateActions: nil.
		hand
			updateFirstIntersection;
			performActions].
]

{
	#category : #updating,
	#'squeak_changestamp' : 'leo-MCPServer 11/22/2026 16:35'
}
SRDesktopInputStrategy >> update: anAspect with: anObject [

	anAspect = #desktopInputUpdated ifTrue: [self processDesktopInput: anObject]
]

{
	#category : #input,
	#'squeak_changestamp' : 'leo-MCPServer 11/20/2026 19:08'
}
SRDesktopInputStrategy >> updateHandInput: anInput [

	| squeezing |
	squeezing := (anInput isMouseButtonDown: RlMouseButton mouseButtonRight)
		or: [anInput isAltDown and: [anInput isKeyDown: RlKeyboardKey keyZ]].
	self avatar rightHand inputState
		updateDesktopTrigger: ((anInput isMouseButtonDown: RlMouseButton mouseButtonLeft)
			ifTrue: [1.0] ifFalse: [0.0])
		squeeze: (squeezing ifTrue: [1.0] ifFalse: [0.0])
		topButton: (self world isTyping not and: [anInput isKeyDown: RlKeyboardKey keyB]).
	self avatar rightHand inputState wheel: (anInput mouseWheel ifNil: [0]).
	self avatar leftHand inputState
		updateDesktopTrigger: 0.0
		squeeze: 0.0
		topButton: false.
]

{
	#category : #'hand updating',
	#'squeak_changestamp' : 'jl-MCPServer 11/20/2026 13:42'
}
SRDesktopInputStrategy >> updateLeftHandFromCamera [
	"Aimed where the head looks."

	| camera target |
	camera := self avatar camera.
	target := camera globalTranslation
		+ (camera forward * self class aimConvergenceDistance).
	^ self
		aimHand: self avatar leftHand
		from: (self handPositionFor: self class leftHandOffset)
		at: target
]

{
	#category : #hands,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 15:16'
}
SRDesktopInputStrategy >> updateRightHandAimingAt: aScreenPosition [
	| hand screenCamera handPos rlRay origin direction hit target |
	hand := self avatar rightHand.
	screenCamera := avatar renderer screenCamera ifNil: [^ hand].
	rlRay := Raylib
		getScreenToWorldRayPosition: aScreenPosition
		camera: screenCamera.
	origin := rlRay position asVector3.
	direction := rlRay direction asVector3 normalized.
	hand grabbedObject
		ifNil: [grabRadius := nil]
		ifNotNil: [:held |
			held aimsWhileHeld ifTrue: [^ self aimHeld: held with: hand along: origin direction: direction].
			^ self dragHand: hand along: origin direction: direction].
	handPos := self handPositionFor: self class rightHandOffset.
	hit := (SRRay origin: origin forward: direction) castNearest: self world.
	target := hit
		ifNil: [origin + (direction * self class aimConvergenceDistance)]
		ifNotNil: [:result | result point].
	^ self aimHand: hand from: handPos at: target
]

{
	#category : #'hand updating',
	#'squeak_changestamp' : 'MCPServer 10/13/2026 14:59'
}
SRDesktopInputStrategy >> updateRightHandFromMouseRay [
	^ self updateRightHandAimingAt: SRDesktopInputState current mousePosition
]

{
	#category : #'hand updating',
	#'squeak_changestamp' : 'MCPServer 8/3/2026 14:38'
}
SRDesktopInputStrategy >> updateRightHandFromScreenCenter [
	"Look mode."

	| rlScreenCenter |
	rlScreenCenter := RlVector2 new
		x: (Raylib getScreenWidth // 2) asFloat;
		y: (Raylib getScreenHeight // 2) asFloat;
		yourself.
	^ self updateRightHandAimingAt: rlScreenCenter
]
