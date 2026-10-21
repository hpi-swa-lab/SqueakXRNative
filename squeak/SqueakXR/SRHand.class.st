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
		'inputState',
		'turnArmed',
		'tool',
		'toolPreview',
		'inputDebugLabel',
		'lastInputEvent'
	],
	#classVars : [
		'EndRate',
		'SharedTool',
		'ShowInputDebug',
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
	#category : #appearance,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 15:00'
}
SRHand class >> leftRayColor [

	^ Color cyan
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
	#category : #appearance,
	#'squeak_changestamp' : 'MCPServer (jl) 10/21/2026 12:39'
}
SRHand class >> rightRayColor [
	^ Color r: 1.0 g: 0.5 b: 0.5
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
	#category : #preferences,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/20/2026 10:46'
}
SRHand class >> sharedTool [
	<preference: 'Shared tool in both hands'
		category: 'SqueakXR'
		description: 'Picking a tool arms both hands instead of only the hand that reached for it. For one-handed use, or when holding two different tools is more to keep track of than it is worth.'
		type: #Boolean>
	^ SharedTool ifNil: [false]
]

{
	#category : #preferences,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/20/2026 10:46'
}
SRHand class >> sharedTool: aBoolean [

	SharedTool := aBoolean.
]

{
	#category : #preferences,
	#'squeak_changestamp' : 'MCPServer (jl) 10/21/2026 12:58'
}
SRHand class >> showInputDebug [
	<preference: 'Hand input debug labels'
		category: 'SqueakXR'
		description: 'Show the live trigger and squeeze values and the last input event as a label at each hand. For telling a controller that is not reporting from an action that is being refused.'
		type: #Boolean>
	^ ShowInputDebug ifNil: [false]
]

{
	#category : #preferences,
	#'squeak_changestamp' : 'MCPServer (jl) 10/21/2026 12:58'
}
SRHand class >> showInputDebug: aBoolean [
	ShowInputDebug := aBoolean.
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
	#category : #tools,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 15:00'
}
SRHand >> basicTool: aTool [

	tool := aTool.
	self updateToolPreview.
]

{
	#category : #input,
	#'squeak_changestamp' : 'lege 8/6/2026 19:05'
}
SRHand >> bottomButton [

	^ self inputState bottomButton
]

{
	#category : #events,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 15:50'
}
SRHand >> forget: anSRObject [
	"anSRObject left the world. A hand that keeps pointing at it keeps the whole thing
	alive -- for a menu that is its items and their text fields."

	grabbedObject == anSRObject ifTrue: [grabbedObject := nil].
	selectedObject == anSRObject ifTrue: [selectedObject := nil].
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
	#'squeak_changestamp' : 'lege 8/5/2026 17:55'
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
			translation: 0 @ 0 @ -5m).
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
	#category : #debugging,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 15:00'
}
SRHand >> noteInputEvent: aString [

	lastInputEvent := aString.
]

{
	#category : #events,
	#'squeak_changestamp' : 'MCPServer 8/10/2026 17:33'
}
SRHand >> onWorldChanged: oldWorld [

	oldWorld ifNotNil: [oldWorld removeDependent: self].
	self world ifNotNil: [:each | each addDependent: self].
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
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 15:00'
}
SRHand >> performActions [

	self updateInputDebugLabel.

	self trigger isJustPressed ifTrue: [
		self squeeze isPressed
			ifTrue: [self noteInputEvent: 'trigger REFUSED: squeezing']
			ifFalse: [
				self noteInputEvent: 'trigger'.
				self rayCast]].

	self squeeze isJustPressed ifTrue: [
		self trigger isPressed
			ifTrue: [self noteInputEvent: 'squeeze REFUSED: triggering']
			ifFalse: [
				self noteInputEvent: 'squeeze: grab'.
				self startGrabbing]].

	self squeeze isJustReleased ifTrue: [
		self noteInputEvent: 'squeeze released'.
		self stopGrabbing].

	self topButton isJustPressed ifTrue: [
		self openMenu].

	self isLeft ifTrue: [
		self updateTeleportAim.
		self bottomButton isJustPressed ifTrue: [
			self avatar toggleOutOfBody]].
]

{
	#category : #actions,
	#'squeak_changestamp' : 'MCPServer (jl) 10/21/2026 12:58'
}
SRHand >> rayCast [

	| result hit |
	result := self castRayForward.
	result ifNil: [^ self noteInputEvent: 'ray hit nothing'].
	hit := result asHandRayIntersection: actionState hand: self.
	(tool notNil and: [tool handleRaycast: hit]) ifTrue: [
		^ self noteInputEvent: tool label , ' used'].
	self noteInputEvent: (tool
		ifNil: ['bare hand on ' , result object class name]
		ifNotNil: [:each | each label , ' DECLINED, hit ' , result object class name]).
	result object onRaycast: hit
]

{
	#category : #appearance,
	#'squeak_changestamp' : 'MCPServer (jl) 10/21/2026 12:39'
}
SRHand >> rayColor [
	^ self isLeft
		ifTrue: [self class leftRayColor]
		ifFalse: [self class rightRayColor]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 5/19/2026 16:32'
}
SRHand >> selectedObject [
	^ selectedObject
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
	#'squeak_changestamp' : 'MCPServer (jl) 10/21/2026 09:54'
}
SRHand >> startGrabbing [

	| ray |
	ray := SRRay
		origin: self globalTranslation
		forward: self forward.
	
	(ray castNearest: self world) ifNotNil: [:collision |
		| target |
		target := collision object grabTarget.
		target ifNil: [^ self].
		grabbedObject := target.
		selectedObject := target.
		grabbedRelativeTransform := self globalTransform inverseTransformation * grabbedObject globalTransform.
		grabbedObject startGrabbing: self].
]

{
	#category : #stepping,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 15:00'
}
SRHand >> step: deltaTime [

	self performActions;
		updateGrabbedObjectTransform;
		highlightSelectedObject.

	self isRight ifTrue: [self updateTurn: deltaTime].
	self isLeft ifTrue: [self avatar ifNotNil: [:a | a updateLocomotion: deltaTime]].
]

{
	#category : #actions,
	#'squeak_changestamp' : 'jl 8/12/2026 18:33'
}
SRHand >> stopGrabbing [

	grabbedObject ifNotNil: [grabbedObject stopGrabbing: self].
	grabbedObject := nil.
]

{
	#category : #actions,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 15:00'
}
SRHand >> teleport [

	| hit |
	self world ifNil: [^ self].
	hit := self rayForward castNearestSolid: self world.
	hit ifNil: [^ self].
	self world avatar teleportTo: hit point.
]

{
	#category : #tools,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/20/2026 10:46'
}
SRHand >> tool [
	^ tool
]

{
	#category : #tools,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/20/2026 10:46'
}
SRHand >> tool: aTool [

	(self class sharedTool and: [avatar notNil])
		ifTrue: [avatar hands do: [:each | each basicTool: aTool]]
		ifFalse: [self basicTool: aTool].
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
	#'squeak_changestamp' : 'MCPServer 8/12/2026 16:49'
}
SRHand >> updateGrabbedObjectTransform [

	grabbedObject ifNotNil: [
		grabbedObject dragTo: self globalTransform * grabbedRelativeTransform].
]

{
	#category : #debugging,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 15:00'
}
SRHand >> updateInputDebugLabel [

	self class showInputDebug ifFalse: [
		inputDebugLabel ifNotNil: [
			inputDebugLabel remove.
			inputDebugLabel := nil].
		^ self].
	inputDebugLabel ifNil: [
		inputDebugLabel := SRTextField new
			color: Color white;
			scale: 0.004 asVector3;

			translation: -3cm @ 4cm @ 6cm;
			yourself.
		self addChild: inputDebugLabel].
	inputDebugLabel text: (String streamContents: [:out |
		out nextPutAll: (self isLeft ifTrue: ['L'] ifFalse: ['R']);
			nextPutAll: ' trig '; nextPutAll: (self trigger value roundTo: 0.01) printString;
			nextPutAll: (self trigger isPressed ifTrue: ['*'] ifFalse: ['']);
			nextPutAll: ' sqz '; nextPutAll: (self squeeze value roundTo: 0.01) printString;
			nextPutAll: (self squeeze isPressed ifTrue: ['*'] ifFalse: ['']);
			cr;
			nextPutAll: (lastInputEvent ifNil: ['--'])]).
]

{
	#category : #actions,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 15:00'
}
SRHand >> updateTeleportAim [

	| stick |
	self avatar ifNil: [^ self].
	SRAvatar locomotionStyle == #teleport ifFalse: [^ self avatar cancelTeleportAim].
	stick := self joystick vector.
	(stick x = 0 and: [stick y = 0])
		ifTrue: [self avatar commitTeleport]
		ifFalse: [self avatar aimTeleportFrom: self]
]

{
	#category : #tools,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/20/2026 13:57'
}
SRHand >> updateToolPreview [

	toolPreview ifNotNil: [
		toolPreview remove.
		toolPreview := nil].
	tool ifNil: [^ self].
	toolPreview := tool newPreviewObject.
	toolPreview ifNotNil: [self addChild: toolPreview].
]

{
	#category : #input,
	#'squeak_changestamp' : 'lege 8/10/2026 11:09'
}
SRHand >> updateTransformFromActions: aSRActionStates [
	
	| pose |
	pose := aSRActionStates aimPoses at: self handIndex.
	self translation: pose position;
		rotation: pose orientation
]

{
	#category : #actions,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 15:00'
}
SRHand >> updateTurn: deltaTime [

	| push |
	self avatar ifNil: [^ self].
	push := self joystick horizontal.
	SRAvatar turnStyle == #smooth ifTrue: [
		^ self avatar turnBy: push * SRAvatar smoothTurnSpeed * deltaTime / 1000.0].
	push = 0 ifTrue: [^ turnArmed := true].
	turnArmed == false ifTrue: [^ self].
	turnArmed := false.
	self avatar turnBy: push sign * SRAvatar snapTurnAngle
]
