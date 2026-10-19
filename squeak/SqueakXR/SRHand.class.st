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
		'actionState',
		'selectedObject',
		'hoveredMenuItem',
		'avatar',
		'inputState',
		'cursor',
		'halo',
		'actions',
		'firstIntersection'
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
	#'squeak_changestamp' : 'phkeese 10/19/2026 15:54'
}
SRHand >> actionsUpdated: aSRActionStates [

	self isRight
		ifTrue: [self inputState updateActionsRight: aSRActionStates]
		ifFalse: [self inputState updateActionsLeft: aSRActionStates].
	
	actionState := aSRActionStates.
	self updateTransformFromActions: aSRActionStates.
	
	self inputState topButton isJustPressed ifTrue: [ 
		self cycleCursor.
		^ self
	].
	
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
	#category : #input,
	#'squeak_changestamp' : 'phkeese 10/8/2026 17:20'
}
SRHand >> cycleCursor [
	| index cursorClasses nextClass |
	cursorClasses := SRCursor subclasses.
	index := cursorClasses indexOf: cursor class.
	cursorClasses := SRCursor subclasses.
	index := cursorClasses indexOf: cursor class.
	cursor class = cursorClasses last
		ifTrue: [ index := 1 ]
		ifFalse: [ index := index + 1 ].
	nextClass := cursorClasses at: index.
	self cursor: nextClass new
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 9/16/2026 14:06'
}
SRHand >> grabbedObject [

	^ self cursor grabbedObject
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
	#category : #input,
	#'squeak_changestamp' : 'lege 8/7/2026 13:04'
}
SRHand >> handleSqueeze: aNumber [

	| prevSqueezePressed threshold |
	self flag: #deprecated.
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
	#'squeak_changestamp' : 'lege 8/7/2026 13:04'
}
SRHand >> handleTrigger: aNumber [

	| prevTriggerPressed threshold |
	self flag: #deprecated.
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
	#'squeak_changestamp' : 'phkeese 10/19/2026 16:32'
}
SRHand >> initialize [

	super initialize.
	
	triggerPressed := false.
	aPressed := false.
	squeezePressed := false.
	menuPressed := false.
	xPressed := false.
	
	inputState := SRHandInputState new.
	actions := OrderedCollection new.
	
	self cursor: SRPointRayCursor new.
	
	self addActions: {
		SRSetFocusAction new.
		SRHighlightTargetsAction new.
		SROpenHaloAction new.
		SRGrabAction new.
		SRSendInputAction new.
	}.
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
	#'squeak_changestamp' : 'phkeese 10/19/2026 14:20'
}
SRHand >> performActions [

	actions do: [:action |
		action perform: self inputState 
	]
]

{
	#category : #actions,
	#'squeak_changestamp' : 'phkeese 10/19/2026 12:52'
}
SRHand >> rayCast [

	| result |
	result := self castRayBackward.
	result ifNotNil: [
		result object onRaycast: (result asHandIntersection: actionState)]
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
	#category : #stepping,
	#'squeak_changestamp' : 'phkeese 9/16/2026 14:09'
}
SRHand >> step: deltaTime [

	self performActions;
		highlightSelectedObject.
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
	#category : #input,
	#'squeak_changestamp' : 'lege 8/10/2026 11:09'
}
SRHand >> updateTransformFromActions: aSRActionStates [
	
	| pose |
	pose := aSRActionStates aimPoses at: self handIndex.
	self translation: pose position;
		rotation: pose orientation
]
