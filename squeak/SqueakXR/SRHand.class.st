"
A VR hand controller.
"
Class {
	#name : #SRHand,
	#superclass : #SRObject,
	#instVars : [
		'handIndex',
		'triggerPressed',
		'squeezePressed',
		'aPressed',
		'menuPressed',
		'xPressed',
		'grabbedObject',
		'grabbedRelativeTransform',
		'actionState',
		'selectedObject',
		'hoveredMenuItem'
	],
	#classVars : [
		'EndRate',
		'StartRate',
		'TransitionEnd',
		'TransitionStart'
	],
	#category : #'SqueakXR-Objects',
	#'squeak_changestamp' : '<historical>'
}

{ #category : #'instance creation' }
SRHand class >> left [

	^ self new handIndex: self leftIndex
]

{ #category : #constants }
SRHand class >> leftIndex [

	^ 1
]

{
	#category : #'distance remapping',
	#'squeak_changestamp' : 'lege 10/17/2025 18:14'
}
SRHand class >> remapGrabDistance: aNumber [
	"see writeup 'Distance Remapping for Grabbing Interactions'"

	| f1 f2 f3 |
	f1 := [:x | StartRate * x].
	f2 :=  [:x || d c |
		d := (EndRate - StartRate) / (TransitionEnd - TransitionStart).
		c := TransitionStart squared * d / 2.
		(x squared / 2) * d + ((StartRate - (d * TransitionStart)) * x) + c].
	f3 := [:x | EndRate * x + (f2 value: TransitionEnd) - (EndRate * TransitionEnd)].
	aNumber <= TransitionStart ifTrue: [^ f1 value: aNumber].
	aNumber >= TransitionEnd ifTrue: [^ f3 value: aNumber].
	^ f2 value: aNumber
]

{ #category : #'instance creation' }
SRHand class >> right [

	^ self new handIndex: self rightIndex
]

{ #category : #constants }
SRHand class >> rightIndex [

	^ 2
]

{
	#category : #'distance remapping',
	#'squeak_changestamp' : 'lege 10/17/2025 17:24'
}
SRHand class >> setDistanceRemappingToDefault [

	self setDistanceRemappingTransitionStart: 2 end: 4 startChangeRate: 1 endChangeRate: 3
]

{
	#category : #'distance remapping',
	#'squeak_changestamp' : 'lege 10/17/2025 17:23'
}
SRHand class >> setDistanceRemappingTransitionStart: transitionStart end: transitionEnd startChangeRate: startRate endChangeRate: endRate [

	TransitionStart := transitionStart.
	TransitionEnd := transitionEnd.
	StartRate := startRate.
	EndRate := endRate.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MCPServer 6/8/2026 10:56'
}
SRHand >> actionsUpdated: aSRActionStates [

	| aJustPressed prevAPressed prevMenuPressed menuJustPressed prevXPressed xJustPressed |
	actionState := aSRActionStates.
	self updateTransformFromActions: aSRActionStates;
		handleTrigger: (aSRActionStates triggers at: self handIndex).
	(actionState thumbstickY at: self handIndex) abs > 0.5 ifTrue: [self rayCast].
	
	"A button -- teleport (right hand only)"
	prevAPressed := aPressed.
	aPressed := aSRActionStates a.
	aJustPressed := aPressed and: prevAPressed not.
	(self isRight and: aJustPressed) ifTrue: [
		self teleport].
	
	"Menu button -- toggle debug HUD (left hand only, button is global)"
	self isLeft ifTrue: [
		prevMenuPressed := menuPressed.
		menuPressed := aSRActionStates menu.
		menuJustPressed := menuPressed and: [prevMenuPressed not].
		menuJustPressed ifTrue: [
			self world debugHUD ifNotNil: [:hud | hud toggleVisibility]]].
	
	"X button -- toggle out-of-body mode (left hand only, button is global)"
	self isLeft ifTrue: [
		prevXPressed := xPressed.
		xPressed := aSRActionStates x.
		xJustPressed := xPressed and: [prevXPressed not].
		xJustPressed ifTrue: [
			self world toggleOutOfBody]].
	
	self handleSqueeze: (aSRActionStates squeeze at: self handIndex)
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MCPServer 5/19/2026 18:30'
}
SRHand >> castRay [
	"Cast a ray from the hand into the world and return the nearest intersection, or nil."

	| ray |
	self world ifNil: [^ nil].
	ray := SRRay
		origin: self globalTranslation
		forward: (self globalTransform localDirToGlobal: Vector3 backward) normalize.
	^ ray castNearest: self world
]

{ #category : #accessing }
SRHand >> handIndex [

	^ handIndex
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 6/8/2026 10:56'
}
SRHand >> handIndex: anInteger [

	| handColor |
	handIndex := anInteger.
	self name: (handIndex caseOf: {
		[self class leftIndex] -> ['Left Hand'].
		[self class rightIndex] -> ['Right Hand']}).
	
	"Color the hand cube and ray to distinguish left from right"
	handColor := self isLeft ifTrue: [Color blue] ifFalse: [Color red].
	self children do: [:child |
		(child isKindOf: SRCube) ifTrue: [child color: handColor]]
]

{
	#category : #grabbing,
	#'squeak_changestamp' : 'MCPServer 5/19/2026 13:36'
}
SRHand >> handleSqueeze: aNumber [

	| prevSqueezePressed threshold |
	prevSqueezePressed := squeezePressed.
	threshold := squeezePressed
		ifTrue: [0.8]
		ifFalse: [0.9].
	squeezePressed := aNumber > threshold.
	
	(squeezePressed and: [prevSqueezePressed not]) ifTrue: [
		triggerPressed
			ifTrue: [self openMenu]
			ifFalse: [self startGrabbing]].
	(squeezePressed not and: [prevSqueezePressed])
		ifTrue: [self stopGrabbing].
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MCPServer 5/19/2026 13:35'
}
SRHand >> handleTrigger: aNumber [

	| prevTriggerPressed threshold |
	prevTriggerPressed := triggerPressed.
	threshold := triggerPressed
		ifTrue: [0.8]
		ifFalse: [0.9].
	triggerPressed := aNumber > threshold.
	
	(triggerPressed and: [prevTriggerPressed not]) ifTrue: [
		squeezePressed
			ifTrue: [self openMenu]
			ifFalse: [self rayCast]].
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MCPServer 6/8/2026 10:55'
}
SRHand >> initialize [

	super initialize.
	
	triggerPressed := false.
	aPressed := false.
	squeezePressed := false.
	menuPressed := false.
	xPressed := false.
	
	self addChild: (SRCube new scale: 10cm asVector3);
		addChild: (SRCube new
			scale: 1cm @ 1cm @ 10m;
			translation: 0 @ 0 @ -5m).
]

{ #category : #testing }
SRHand >> isLeft [

	^ self handIndex = self class leftIndex
]

{ #category : #testing }
SRHand >> isRight [

	^ self handIndex = self class rightIndex
]

{
	#category : #actions,
	#'squeak_changestamp' : 'MCPServer 6/9/2026 14:44'
}
SRHand >> menuPlacementPosition [
	"Place the menu in front of the viewer (camera), not the hand.
	Uses the camera's look direction at a comfortable reading distance.
	Raycasts from the hand to avoid placing the menu inside objects."
	| viewer forward preferredDistance margin minDistance hit distance |
	viewer := self viewerPosition.
	forward := self world viewerForward.
	forward := forward normalize.
	preferredDistance := 0.5.
	margin := 0.05.
	minDistance := 0.25.
	hit := self castRay.
	distance := preferredDistance.
	hit ifNotNil: [
		| hitDistance |
		hitDistance := (hit point - viewer) length.
		distance := (hitDistance - margin) min: preferredDistance].
	distance := distance max: minDistance.
	^ viewer + (forward * distance)
]

{ #category : #events }
SRHand >> onWorldChanged: oldWorld [

	super onWorldChanged: oldWorld.
	
	oldWorld ifNotNil: [oldWorld removeDependent: self].
	self world addDependent: self.
]

{
	#category : #menu,
	#'squeak_changestamp' : 'MCPServer 6/2/2026 10:37'
}
SRHand >> openContextMenuFor: anObject [
	| pos viewer |
	pos := self menuPlacementPosition.
	viewer := self viewerPosition.
	SRMenu contextMenuFor: anObject at: pos facing: viewer in: self world.
]

{
	#category : #menu,
	#'squeak_changestamp' : 'MCPServer 5/19/2026 13:36'
}
SRHand >> openMenu [
	| existingMenus |
	existingMenus := self world allDescendantsSelect: [:obj | obj isMenu].
	existingMenus ifNotEmpty: [
		existingMenus do: [:m | m close].
		^ self].
	grabbedObject
		ifNotNil: [self openContextMenuFor: grabbedObject]
		ifNil: [self openWorldMenu].
]

{
	#category : #menu,
	#'squeak_changestamp' : 'MCPServer 6/2/2026 10:37'
}
SRHand >> openWorldMenu [
	| pos viewer |
	pos := self menuPlacementPosition.
	viewer := self viewerPosition.
	SRMenu worldMenuAt: pos facing: viewer in: self world.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MCPServer 5/19/2026 18:30'
}
SRHand >> rayCast [

	| result |
	result := self castRay.
	result ifNotNil: [
		result object onRaycast: (result asHandRayIntersection: actionState)]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 5/19/2026 16:32'
}
SRHand >> selectedObject [
	^ selectedObject
]

{
	#category : #grabbing,
	#'squeak_changestamp' : 'MCPServer 5/19/2026 16:31'
}
SRHand >> startGrabbing [

	| ray |
	ray := SRRay
		origin: self globalTranslation
		forward: (self globalTransform localDirToGlobal: Vector3 backward) normalize.
	
	(ray castNearest: self world) ifNotNil: [:collision |
		| target |
		target := collision object grabTarget.
		target ifNil: [^ self].
		grabbedObject := target.
		selectedObject := target.
		Transcript cr; show: 'Selected: ', target class name, ' (', (target name ifNil: ['unnamed']), ')'.
		grabbedRelativeTransform := self globalTransform inverseTransformation * grabbedObject globalTransform].
]

{
	#category : #grabbing,
	#'squeak_changestamp' : 'MCPServer 5/26/2026 17:46'
}
SRHand >> step: deltaTime [

	| painter geom |
	grabbedObject ifNotNil: [
		grabbedObject globalTransform: self globalTransform * grabbedRelativeTransform].
	
	
	selectedObject ifNotNil: [
		painter := self gizmoPainter.
		painter ifNotNil: [
			geom := selectedObject collisionGeometry.
			(geom isKindOf: SRCollisionBox) ifTrue: [
				painter gizmoWireBox: geom color: Color green].
			(geom isKindOf: SRCollisionPlane) ifTrue: [
				painter gizmoWirePlane: geom color: Color green]]].
]

{
	#category : #grabbing,
	#'squeak_changestamp' : 'MCPServer 5/13/2026 13:24'
}
SRHand >> stopGrabbing [

	grabbedObject := nil.
]

{ #category : #'as yet unclassified' }
SRHand >> teleport [

	| forward groundPoint t translation |
	"hand points backward, so we need to start with Vector3 backward instead of forward"
	forward := self globalTransform localDirToGlobal: Vector3 backward.
	forward y > 0 ifTrue: [^ self]. "hand is not pointing at ground"
	translation := self globalTranslation.
	t := (translation y / forward y) negated.
	groundPoint := forward * t + translation.
	self world avatar translation: groundPoint.
]

{ #category : #'as yet unclassified' }
SRHand >> update: aSymbol with: anObject [

	aSymbol = #actionsUpdated ifTrue: [self actionsUpdated: anObject]
]

{
	#category : #'xr-input',
	#'squeak_changestamp' : 'MCPServer 6/9/2026 14:52'
}
SRHand >> updateTransformFromActions: aSRActionStates [
	"XR aim poses are in stage (world) space. Since the hand is a child of
	 the avatar, use globalTransform: so the avatar's own transform does
	 not offset the hand. Also convert OpenXR types to our Vector3/Quaternion."
	| pose pos quat transform |
	pose := aSRActionStates aimPoses at: self handIndex.
	pos := pose position.
	quat := pose orientation.
	transform := Matrix4x4 fromQuaternion: (Quaternion a: quat w b: quat x c: quat y d: quat z).
	transform translation: (Vector3 x: pos x y: pos y z: pos z).
	self globalTransform: transform
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 6/9/2026 14:44'
}
SRHand >> viewerPosition [
	"Return the user's head/camera position in world space.
	 Fall back to the hand position if no world is available."
	| w |
	w := self world.
	w ifNil: [^ self globalTranslation].
	^ w viewerPosition
]
