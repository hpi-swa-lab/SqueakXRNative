"
Desktop input emulator for XR interactions in flat mode.
"
Class {
	#name : #SRXRInputEmulator,
	#superclass : #SRObject,
	#instVars : [
		'emulatedCamera',
		'debugHUD',
		'grabRadius',
		'grabBearing',
		'grabHeight',
		'grabTransform'
	],
	#category : #'SqueakXR-Objects',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #constants,
	#'squeak_changestamp' : 'MCPServer 8/10/2026 13:56'
}
SRXRInputEmulator class >> aimConvergenceDistance [
	"Fallback aim distance when the ray meets nothing."

	^ 5m
]

{
	#category : #constants,
	#'squeak_changestamp' : 'jl 8/10/2026 14:49'
}
SRXRInputEmulator class >> handOffset [
	"(right, up, ahead) in a yaw-only head frame. "
	^  34cm @ -57cm @ 47cm
]

{
	#category : #constants,
	#'squeak_changestamp' : 'MCPServer 8/10/2026 13:56'
}
SRXRInputEmulator class >> leftHandOffset [
	^ self handOffset * (-1 @ 1 @ 1)
]

{
	#category : #constants,
	#'squeak_changestamp' : 'MCPServer 8/3/2026 15:55'
}
SRXRInputEmulator class >> rightHandOffset [
	^ self handOffset
]

{
	#category : #hands,
	#'squeak_changestamp' : 'MCPServer (jl) 10/21/2026 09:52'
}
SRXRInputEmulator >> aimHand: aHand from: aPosition at: aTarget [
	| direction |
	direction := aTarget - aPosition.
	direction isZero ifTrue: [^ aHand].
	direction := direction normalized.
	aHand globalTransform: (Matrix4x4
		objectLookAt: aPosition + direction
		from: aPosition
		up: self world camera up).
	^ aHand
]

{
	#category : #input,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/20/2026 17:10'
}
SRXRInputEmulator >> bearingFrom: anEye to: aPoint [
	"Degrees about the vertical axis. Height is ignored: the cylinder's axis is
	vertical, so only the horizontal direction names a position on it."

	| d |
	d := aPoint - anEye.
	^ (d x arcTan: d z) radiansToDegrees
]

{
	#category : #input,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/20/2026 17:10'
}
SRXRInputEmulator >> cylinderHitFrom: anOrigin direction: aDirection eye: anEye radius: aRadius [
	"Where the cursor ray leaves a vertical cylinder of that radius about the eye.
	The far root: the near one is behind the viewer."

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
SRXRInputEmulator >> debugHUD [

	^ debugHUD
]

{
	#category : #input,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/20/2026 17:10'
}
SRXRInputEmulator >> dragHand: aHand along: anOrigin direction: aDirection [
	"While something is held, the hand slides along the mouse ray and keeps the
	rotation it had. The emulated hand never translates -- it pivots at a fixed
	shoulder offset -- so aiming it at the cursor swings the held object on a
	sphere and turns it as it goes, which is what makes flat-mode dragging
	painful. A real hand moves; only this one cannot."

	| eye t point lift |
	eye := self world avatar camera globalTranslation.
	grabRadius ifNil: [
		| held |
		held := aHand grabbedObject globalTranslation.
		"A vertical cylinder about the viewer: a plane would push the thing away
		as it goes sideways, and a sphere would turn it away from us. On the
		cylinder the distance is constant and the yaw keeps it facing us.
		Radius is measured from the eye each frame, so walking carries it."
		grabRadius := ((held x - eye x) squared + (held z - eye z) squared) sqrt.
		grabBearing := self bearingFrom: eye to: held.
		grabHeight := held y.
		grabTransform := aHand globalTransform copy].
	t := self
		cylinderHitFrom: anOrigin direction: aDirection eye: eye radius: grabRadius.
	t ifNil: [^ aHand].
	point := anOrigin + (aDirection * t).
	lift := Matrix4x4 withOffset: (Vector3 x: 0 y: point y - grabHeight z: 0).
	"Rotating the whole hand about the eye's vertical axis is what turns the held
	object to face us: the object rides the hand, so it yaws without tumbling."
	aHand globalTransform: (Matrix4x4
		rotatedBy: (self bearingFrom: eye to: point) - grabBearing
		around: Vector3 up
		centeredAt: eye) * (lift * grabTransform).
	^ aHand
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 5/13/2026 13:58'
}
SRXRInputEmulator >> emulatedCamera [

	^ emulatedCamera
]

{
	#category : #hands,
	#'squeak_changestamp' : 'MCPServer 8/3/2026 14:38'
}
SRXRInputEmulator >> handPositionFor: anOffset [
	"Yaw-only head frame, so the hands stay put when the head pitches."

	| camera ahead right |
	camera := self world avatar camera.
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
	#'squeak_changestamp' : 'MCPServer 5/13/2026 13:58'
}
SRXRInputEmulator >> initialize [

	super initialize.
	emulatedCamera := SRSimpleAvatarMovementEmulator new.
	debugHUD := SRXRDebugHUD new.
	self addChild: debugHUD
]

{
	#category : #testing,
	#'squeak_changestamp' : 'MCPServer 5/11/2026 17:40'
}
SRXRInputEmulator >> isXRInputEmulator [

	^ true
]

{
	#category : #events,
	#'squeak_changestamp' : 'MCPServer 5/13/2026 13:58'
}
SRXRInputEmulator >> onWorldChanged: oldWorld [

	super onWorldChanged: oldWorld.
	self world ifNotNil: [:aWorld |
		emulatedCamera avatar: aWorld avatar]
]

{
	#category : #stepping,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/20/2026 15:16'
}
SRXRInputEmulator >> step: delta [
	"Desktop stand-in for the headset and the controllers: TAB toggles look mode,
	WASD drives the rig, the mouse aims the right hand."

	| input |
	input := SRDesktopInputState current.
	
	(input isKeyPressed: RlKeyboardKey keyF2) ifTrue: [
		debugHUD toggleVisibility].
	
	(input isKeyPressed: RlKeyboardKey keyF3) ifTrue: [
		self world avatar toggleOutOfBody].
	
	emulatedCamera update: delta.
	
	(input isKeyPressed: RlKeyboardKey keyTab) ifTrue: [
		emulatedCamera toggleLookMode].
	
	self updateLeftHandFromCamera.
	emulatedCamera lookModeEnabled
		ifTrue: [self updateRightHandFromScreenCenter]
		ifFalse: [self updateRightHandFromMouseRay].
	
	self updateHandInput: input.
]

{
	#category : #input,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/20/2026 15:20'
}
SRXRInputEmulator >> updateHandInput: anInput [
	"The mouse is the right hand: left button is the trigger, right button the
	squeeze, B the menu button. B reaches the right hand only -- both would open
	the menu and close it again in the same frame, since #openMenuForHand: toggles.

	Driving SRHandInputState rather than SRHand directly is what makes
	#performActions -- and so the tools, the grab and the app menu -- behave the
	same in flat mode as in XR."

	| avatar squeezing |
	avatar := self world ifNil: [^ self] ifNotNil: [:w | w avatar].
	avatar ifNil: [^ self].
	"Alt+Z holds the grab without holding the mouse down. A grab lasts exactly as
	long as the squeeze, so grab-then-B is otherwise a two-handed stretch."
	squeezing := (anInput isMouseButtonDown: RlMouseButton mouseButtonRight)
		or: [anInput isAltDown and: [anInput isKeyDown: RlKeyboardKey keyZ]].
	avatar rightHand inputState
		updateDesktopTrigger: ((anInput isMouseButtonDown: RlMouseButton mouseButtonLeft)
			ifTrue: [1.0] ifFalse: [0.0])
		squeeze: (squeezing ifTrue: [1.0] ifFalse: [0.0])
		topButton: (anInput isKeyDown: RlKeyboardKey keyB).
	avatar leftHand inputState
		updateDesktopTrigger: 0.0
		squeeze: 0.0
		topButton: false.
]

{
	#category : #'hand updating',
	#'squeak_changestamp' : 'MCPServer 8/3/2026 14:38'
}
SRXRInputEmulator >> updateLeftHandFromCamera [
	"Aimed where the head looks."

	| camera target |
	camera := self world avatar camera.
	target := camera globalTranslation
		+ (camera forward * self class aimConvergenceDistance).
	^ self
		aimHand: self world avatar leftHand
		from: (self handPositionFor: self class leftHandOffset)
		at: target
]

{
	#category : #hands,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/20/2026 17:10'
}
SRXRInputEmulator >> updateRightHandAimingAt: aScreenPosition [
	| hand handPos rlRay origin direction hit target |
	hand := self world avatar rightHand.
	rlRay := Raylib
		getScreenToWorldRayPosition: aScreenPosition
		camera: self world renderer camera.
	origin := rlRay position asVector3.
	direction := rlRay direction asVector3 normalized.
	hand grabbedObject
		ifNil: [grabRadius := nil]
		ifNotNil: [^ self dragHand: hand along: origin direction: direction].
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
SRXRInputEmulator >> updateRightHandFromMouseRay [
	^ self updateRightHandAimingAt: SRDesktopInputState current mousePosition
]

{
	#category : #'hand updating',
	#'squeak_changestamp' : 'MCPServer 8/3/2026 14:38'
}
SRXRInputEmulator >> updateRightHandFromScreenCenter [
	"Look mode."

	| rlScreenCenter |
	rlScreenCenter := RlVector2 new
		x: (Raylib getScreenWidth // 2) asFloat;
		y: (Raylib getScreenHeight // 2) asFloat;
		yourself.
	^ self updateRightHandAimingAt: rlScreenCenter
]
