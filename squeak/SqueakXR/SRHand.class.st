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
		'hoveredMenuItem',
		'avatar',
		'inputState'
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
	#category : #input,
	#'squeak_changestamp' : 'lege 8/6/2026 18:58'
}
SRHand >> actionsUpdated: aSRActionStates [

	self isRight
		ifTrue: [self inputState updateActionsRight: aSRActionStates]
		ifFalse: [self inputState updateActionsLeft: aSRActionStates].
	
	actionState := aSRActionStates.
	
	self updateTransformFromActions: aSRActionStates.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 6/30/2026 17:19'
}
SRHand >> avatar [

	^ avatar
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 6/30/2026 17:19'
}
SRHand >> avatar: anSRAvatar [

	avatar := anSRAvatar
]

{
	#category : #input,
	#'squeak_changestamp' : 'lege 8/6/2026 19:05'
}
SRHand >> bottomButton [

	^ self inputState bottomButton
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 6/30/2026 17:19'
}
SRHand >> grabbedObject [

	^ grabbedObject
]

{ #category : #accessing }
SRHand >> handIndex [

	^ handIndex
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'SqueakXR 6/25/2026 16:26'
}
SRHand >> handIndex: anInteger [

	| handColor |
	handIndex := anInteger.
	self name: (handIndex caseOf: {
		[self class leftIndex] -> ['Left Hand'].
		[self class rightIndex] -> ['Right Hand']}).
	
	handColor := self isLeft ifTrue: [Color blue] ifFalse: [Color red].
	self children do: [:child | child color: handColor].
]

{
	#category : #input,
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
	#category : #input,
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
	#category : #stepping,
	#'squeak_changestamp' : 'lege 8/6/2026 19:10'
}
SRHand >> highlightSelectedObject [

	| painter |
	selectedObject ifNotNil: [
		painter := self gizmoPainter.
		painter ifNotNil: [
			selectedObject collisionGeometryDo: [:geom |
				geom isCollisionBox ifTrue: [
					painter gizmoWireBox: geom color: Color green].
				geom isCollisionPlane ifTrue: [
					painter gizmoWirePlane: geom color: Color green]]]].
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'phkeese 8/10/2026 15:34'
}
SRHand >> initialize [

	super initialize.
	
	triggerPressed := false.
	aPressed := false.
	squeezePressed := false.
	menuPressed := false.
	xPressed := false.
	
	inputState := SRHandInputState new.
	
	self addChild: (SRCube new scale: 10cm asVector3);
		addChild: (SRCube new
			scale: 1cm @ 1cm @ 10m;
			translation: 0 @ 0 @ -5m);
		addChild: (SRInputDebugger new
			scale: 10cm asVector3;
			translation: 0 @ 10cm @ 0);
		addChild: (SRGoGoExtender new
			hand: self).
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 8/6/2026 16:47'
}
SRHand >> inputState [

	^ inputState
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
	#category : #input,
	#'squeak_changestamp' : 'lege 8/6/2026 19:06'
}
SRHand >> joystick [

	^ self inputState joystick
]

{
	#category : #input,
	#'squeak_changestamp' : 'lege 8/6/2026 19:05'
}
SRHand >> menuButton [

	^ self inputState menuButton
]

{
	#category : #events,
	#'squeak_changestamp' : 'lege 7/21/2026 18:06'
}
SRHand >> onWorldChanged: oldWorld [

	oldWorld ifNotNil: [oldWorld removeDependent: self].
	self world addDependent: self.
]

{
	#category : #actions,
	#'squeak_changestamp' : 'lege 7/21/2026 14:57'
}
SRHand >> openMenu [

	self avatar openMenuForHand: self
]

{
	#category : #stepping,
	#'squeak_changestamp' : 'lege 8/7/2026 11:49'
}
SRHand >> performActions [

	self trigger isJustPressed ifTrue: [
		self squeeze isPressed
			ifTrue: [self openMenu]
			ifFalse: [self rayCast]].
	
	self squeeze isJustPressed ifTrue: [
		self trigger isPressed
			ifTrue: [self openMenu]
			ifFalse: [self startGrabbing]].
	
	self squeeze isJustReleased ifTrue: [
		self stopGrabbing].
	
	self isRight ifTrue: [
		self bottomButton isJustPressed ifTrue: [
			self teleport]].
	
	self isLeft ifTrue: [
		self menuButton isJustPressed ifTrue: [
			self world debugHUD ifNotNil: [:hud | hud toggleVisibility]].
		self bottomButton isJustPressed ifTrue: [
			self avatar toggleOutOfBody]].
]

{
	#category : #actions,
	#'squeak_changestamp' : 'SqueakXR 6/26/2026 18:46'
}
SRHand >> rayCast [

	| result |
	result := self castRayBackward.
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
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 8/10/2026 15:33'
}
SRHand >> shoulderPosition [
	| xoff offset |
	xoff := self avatar shoulderWidth / 2.
	self handIndex = 1 ifFalse: [xoff := -1 * xoff].
	offset := (xoff@(self avatar shoulderDepth)@0).
	^ self avatar camera position - offset
]

{
	#category : #input,
	#'squeak_changestamp' : 'lege 8/6/2026 19:05'
}
SRHand >> squeeze [

	^ self inputState squeeze
]

{
	#category : #actions,
	#'squeak_changestamp' : 'MCPServer 6/8/2026 15:07'
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
		grabbedRelativeTransform := self globalTransform inverseTransformation * grabbedObject globalTransform].
]

{
	#category : #stepping,
	#'squeak_changestamp' : 'lege 8/6/2026 19:10'
}
SRHand >> step: deltaTime [

	self performActions;
		updateGrabbedObjectTransform;
		highlightSelectedObject.
]

{
	#category : #actions,
	#'squeak_changestamp' : 'MCPServer 5/13/2026 13:24'
}
SRHand >> stopGrabbing [

	grabbedObject := nil.
]

{ #category : #actions }
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

{
	#category : #input,
	#'squeak_changestamp' : 'lege 8/6/2026 19:06'
}
SRHand >> topButton [

	^ self inputState topButton
]

{
	#category : #input,
	#'squeak_changestamp' : 'lege 8/6/2026 19:05'
}
SRHand >> trigger [

	^ self inputState trigger
]

{ #category : #updating }
SRHand >> update: aSymbol with: anObject [

	aSymbol = #actionsUpdated ifTrue: [self actionsUpdated: anObject]
]

{
	#category : #stepping,
	#'squeak_changestamp' : 'lege 8/6/2026 19:10'
}
SRHand >> updateGrabbedObjectTransform [

	grabbedObject ifNotNil: [
		grabbedObject globalTransform: self globalTransform * grabbedRelativeTransform].
]

{
	#category : #input,
	#'squeak_changestamp' : 'phkeese 8/10/2026 11:35'
}
SRHand >> updateTransformFromActions: aSRActionStates [
	
	| pose |
	pose := aSRActionStates aimPoses at: self handIndex.
	self position: pose position;
		rotation: pose orientation
]
