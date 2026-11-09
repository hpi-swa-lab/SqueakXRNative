"
A VR hand controller.
"
Class {
	#name : #SRHand,
	#superclass : #SRObject,
	#instVars : [
		'aPressed',
		'actionState',
		'actions',
		'avatar',
		'cursor',
		'firstIntersection',
		'halo',
		'handIndex',
		'inputDebugLabel',
		'inputState',
		'lastInputEvent',
		'selectedObject',
		'squeezePressed',
		'tool',
		'toolPreview',
		'triggerPressed',
		'xPressed'
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

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'MCPServer (leo) 11/9/2026 15:32'
}
SRHand class >> left [

	^ self new
		handIndex: self leftIndex;
		addFirstAction: SRTeleportAction new;
		yourself
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

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'MCPServer (leo) 11/9/2026 15:32'
}
SRHand class >> right [

	^ self new
		handIndex: self rightIndex;
		addFirstAction: SRSnapTurnAction new;
		yourself
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
	#'squeak_changestamp' : 'MCPServer (leo) 11/9/2026 14:26'
}
SRHand >> actionsUpdated: aSRActionStates [

	self isRight
		ifTrue: [self inputState updateActionsRight: aSRActionStates]
		ifFalse: [self inputState updateActionsLeft: aSRActionStates].
	
	actionState := aSRActionStates.
	self updateTransformFromActions: aSRActionStates.
	
	self cursor updateActions: aSRActionStates.
	self updateFirstIntersection.
	self performActions.
]

{
	#category : #actions,
	#'squeak_changestamp' : 'phkeese 10/19/2026 13:32'
}
SRHand >> addAction: anSRHandAction [

	anSRHandAction hand: self.
	actions add: anSRHandAction.
]

{
	#category : #actions,
	#'squeak_changestamp' : 'phkeese 10/19/2026 16:32'
}
SRHand >> addActions: aList [

	aList do: [:action | self addAction: action ]
]

{
	#category : #actions,
	#'squeak_changestamp' : 'MCPServer (leo) 11/9/2026 14:56'
}
SRHand >> addFirstAction: anSRHandAction [

	anSRHandAction hand: self.
	actions addFirst: anSRHandAction.
]

{
	#category : #actions,
	#'squeak_changestamp' : 'MCPServer (leo) 11/9/2026 14:53'
}
SRHand >> appUnderRay [

	^ self cursorTarget ifNotNil: [:target | target app]
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
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/14/2026 16:40'
}
SRHand >> collisionGeometry [ 

	^ nil
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 9/24/2026 14:31'
}
SRHand >> color [
	^ self isLeft ifTrue: [ Color blue ] ifFalse: [ Color red ].
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 9/16/2026 14:06'
}
SRHand >> cursor [
	^ cursor
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 9/16/2026 16:26'
}
SRHand >> cursor: anSRCursor [
	
	(cursor = anSRCursor) ifTrue: [ ^self ].
	cursor ifNotNil: [
		self removeChild: cursor.
		cursor hand: nil.
	].
	cursor := anSRCursor.
	cursor ifNotNil: [
		cursor hand: self.
		self addChild: cursor.
	].
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/19/2026 15:59'
}
SRHand >> cursorPoint [

	"Answer my cursor's point, if there is one."
	^ firstIntersection ifNotNil: [:inter | inter point ]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/19/2026 15:58'
}
SRHand >> cursorTarget [

	"Answer my cursor's target, if there is one."
	^ firstIntersection ifNotNil: [:inter | inter object ]
]

{
	#category : #events,
	#'squeak_changestamp' : 'MCPServer (leo) 11/9/2026 15:01'
}
SRHand >> forget: anSRObject [

	actions do: [:action | action forget: anSRObject].
	selectedObject == anSRObject ifTrue: [selectedObject := nil].
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer (leo) 11/9/2026 14:28'
}
SRHand >> grabbedObject [

	actions do: [:action | action grabbedObject ifNotNil: [:object | ^ object]].
	^ nil
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/9/2026 13:45'
}
SRHand >> halo [
	^ halo
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/9/2026 13:45'
}
SRHand >> halo: anObject [
	halo := anObject
]

{
	#category : #input,
	#'squeak_changestamp' : 'phkeese 11/4/2026 14:03'
}
SRHand >> haloTransform [

	"Answer a transform to place a halo anchored to this hand at"
	^ self globalTransform * (Matrix4x4 withOffset: 0@5cm@0)
]

{ #category : #accessing }
SRHand >> handIndex [

	^ handIndex
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 9/24/2026 14:30'
}
SRHand >> handIndex: anInteger [

	| handColor |
	handIndex := anInteger.
	self name: (handIndex caseOf: {
		[self class leftIndex] -> ['Left Hand'].
		[self class rightIndex] -> ['Right Hand']}).
	
	handColor := self color.
	self children do: [:child |
		(child respondsTo: #color:) ifTrue: [ child color: handColor ]
	]
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
	#'squeak_changestamp' : 'MCPServer (leo) 11/9/2026 15:01'
}
SRHand >> initialize [

	super initialize.
	
	triggerPressed := false.
	aPressed := false.
	squeezePressed := false.
	xPressed := false.
	
	inputState := SRHandInputState new.
	actions := OrderedCollection new.
	
	self cursor: SRPointRayCursor new.
	
	self addActions: {
		SRSetFocusAction new.
		SRHighlightTargetsAction new.
		SROpenHaloAction new.
		SROpenMenuAction new.
		SRGrabAction new.
		SRSendInputAction new.
	}.
	
	self addChild: (SRCube new
		scale: 6cm asVector3;
		ignoreCollision: true).
	self addChild: (SRCube new
		scale: 4cm@10cm@4cm;
		rotation: (Quaternion angle: -45 axis: Vector3 right);
		position: 0@ -5cm@5cm;
		ignoreCollision: true
	).
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
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/30/2026 17:16'
}
SRHand >> opposite [ 

	^self isRight 
		ifTrue: [self avatar leftHand]
		ifFalse: [self avatar rightHand]
]

{
	#category : #stepping,
	#'squeak_changestamp' : 'phkeese 10/30/2026 17:11'
}
SRHand >> performActions [

	[actions do: [:action |
		(action run: self inputState) ifFalse: [^self]
	]]
	on: Error
	do: [:error |
		error printVerboseOn: Transcript.
	]
]

{
	#category : #actions,
	#'squeak_changestamp' : 'phkeese 10/20/2026 14:45'
}
SRHand >> printOn: aStream [

	| side |
	side := self isLeft ifTrue: [ 'left' ] ifFalse: [ 'right' ].
	aStream nextPutAll: 'an ', (self class name), '(', side, ')'.
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
	#category : #updating,
	#'squeak_changestamp' : 'phkeese 10/19/2026 15:58'
}
SRHand >> selectIntersection: intersections [

	"Select parents over their children."
	^ (intersections sorted: [:a :b |
		(a distance < b distance) or: [b object hasAncestor: a object]
	])
	ifEmpty: [ nil ]
	ifNotEmpty: [:sorted | sorted first ]
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
	#category : #updating,
	#'squeak_changestamp' : 'phkeese 10/19/2026 15:56'
}
SRHand >> updateFirstIntersection [ 

	"Prefer parents over their children and second-pass objects over the others."
	| all secondPass |
	all := self cursor intersections.
	secondPass := all select: [:inter | inter object renderInSecondPass ].
	firstIntersection := self selectIntersection: (secondPass ifEmpty: [ all ]).
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
	#'squeak_changestamp' : 'MCPServer (leo) 11/6/2026 16:34'
}
SRHand >> updateTransformFromActions: aSRActionStates [
	
	| pose |
	pose := aSRActionStates aimPoses at: self handIndex.
	self translation: pose position;
		rotation: pose orientation
]
