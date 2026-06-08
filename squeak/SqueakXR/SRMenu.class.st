"
3D menu panel with labeled items.
"
Class {
	#name : #SRMenu,
	#superclass : #SRObject,
	#instVars : [
		'items',
		'slabWidth',
		'slabHeight',
		'slabDepth',
		'slabColor',
		'wireColor',
		'textScale',
		'rowSpacing'
	],
	#category : #'SqueakXR-Objects',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'MCPServer 6/2/2026 10:37'
}
SRMenu class >> contextMenuFor: anObject at: aPosition facing: aViewerPosition in: aWorld [
	"aViewerPosition is the user's head/camera position; the menu will face it."
	| menu |
	menu := self new.
	menu addItem: 'Inspect' action: [
		anObject inspect].
	menu addItem: 'Clone' action: [
		| clone |
		clone := anObject veryDeepCopy.
		clone position: anObject position + (0.3 @ 0 @ 0).
		anObject parent addChild: clone].
	menu addItem: 'Remove' action: [
		anObject remove].
	(anObject respondsTo: #addCustomMenuItemsTo:)
		ifTrue: [anObject addCustomMenuItemsTo: menu].
	menu openAt: aPosition facingViewer: aViewerPosition.
	aWorld addChild: menu.
	^ menu.
]

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'MCPServer 6/8/2026 10:54'
}
SRMenu class >> worldMenuAt: aPosition facing: aViewerPosition in: aWorld [
	"aViewerPosition is the user's head/camera position; the menu will face it."
	| menu |
	menu := self new.
	menu addItem: 'Spawn Cube' action: [
		aWorld addChild: (SRCube new
			position: aPosition;
			scale: 0.3 @ 0.3 @ 0.3;
			yourself)].
	(Smalltalk hasClassNamed: #SWAGameCube) ifTrue: [
		menu addItem: 'Spawn SWACube' action: [
			aWorld addChild: (SWAGameCube new
				position: aPosition;
				scale: 0.1 @ 0.1 @ 0.1;
				color: Color green;
				yourself)]].
	(Smalltalk hasClassNamed: #SWAGameXR) ifTrue: [
		menu addItem: 'Spawn SWAGame' action: [
			| game |
			game := SWAGameXR new.
			game position: aPosition.
			aWorld addChild: game.
			game generateWorld]].
	menu addItem: 'Scene Tree' action: [
		SRSceneTreeInspector openOn: aWorld].
	menu addItem: 'Frame Time Graph' action: [
		aWorld addChild: (SRFrameTimeGraph new
			position: aPosition;
			yourself)].
	"--- Debug tools ---"
	menu addItem: (aWorld debugHUD ifNotNil: [:h | h visible ifTrue: ['Debug HUD: ON'] ifFalse: ['Debug HUD: OFF']] ifNil: ['Debug HUD: N/A']) action: [
		aWorld debugHUD ifNotNil: [:h | h toggleVisibility]].
	menu addItem: (aWorld outOfBodyMode ifTrue: ['Return to Body'] ifFalse: ['Out-of-Body Mode']) action: [
		aWorld toggleOutOfBody].
	(Smalltalk hasClassNamed: #SBMCPServer) ifTrue: [
		| mcp label |
		mcp := Smalltalk at: #SBMCPServer.
		label := mcp shared isRunning
			ifTrue: ['MCP Server: ON']
			ifFalse: ['MCP Server: OFF'].
		menu addItem: label action: [mcp toggle]].
	(Smalltalk hasClassNamed: #MCPLogger) ifTrue: [
		menu addItem: 'Open MCP Log' action: [
			(Smalltalk at: #MCPLogger) openLog]].
	menu addItem: 'Workspace' action: [
		Workspace open].
	menu addItem: 'System Browser' action: [
		Browser open].
	menu openAt: aPosition facingViewer: aViewerPosition.
	aWorld addChild: menu.
	^ menu.
]

{
	#category : #building,
	#'squeak_changestamp' : 'MCPServer 5/19/2026 11:25'
}
SRMenu >> addItem: aString action: aBlock [
	items add: (Association key: aString value: aBlock).
	self rebuild.
]

{
	#category : #actions,
	#'squeak_changestamp' : 'MCPServer 5/19/2026 11:26'
}
SRMenu >> close [
	self remove.
]

{
	#category : #collisions,
	#'squeak_changestamp' : 'MCPServer 5/19/2026 13:08'
}
SRMenu >> collisionGeometry [
	slabHeight = 0 ifTrue: [^ nil].
	^ SRCollisionBox new
		center: self globalTranslation;
		halfExtents: self globalScale * (slabWidth / 2 @ (slabHeight / 2) @ (slabDepth / 2));
		rotation: self globalRotation;
		object: self.
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'MCPServer 5/19/2026 13:10'
}
SRMenu >> initialize [
	super initialize.
	items := OrderedCollection new.
	slabWidth := 0.15.
	slabHeight := 0.
	slabDepth := 0.005.
	slabColor := Color r: 0.05 g: 0.05 b: 0.1.
	wireColor := Color r: 0.3 g: 0.3 b: 0.5.
	textScale := 0.015.
	rowSpacing := 0.025.
]

{
	#category : #testing,
	#'squeak_changestamp' : 'MCPServer 5/19/2026 11:27'
}
SRMenu >> isMenu [
	^ true.
]

{
	#category : #actions,
	#'squeak_changestamp' : 'MCPServer 6/8/2026 15:08'
}
SRMenu >> openAt: aPosition facingViewer: aViewerPosition [

	| toViewer flat fwd yaw toViewerNorm pitchAngle pitch |
	self position: aPosition.
	toViewer := aViewerPosition - aPosition.
	flat := (toViewer x @ 0 @ toViewer z) safelyNormalize.
	flat isZero ifTrue: [^ self].
	fwd := Vector3 forward.
	yaw := (fwd dot: flat) < -0.9999
		ifTrue: [Quaternion new angle: 180 axis: Vector3 up]
		ifFalse: [Quaternion new from: fwd to: flat].
	toViewerNorm := toViewer safelyNormalize.
	pitchAngle := toViewerNorm y arcSin negated.
	pitch := Quaternion new radiansAngle: pitchAngle axis: Vector3 right.
	self rotation: pitch * yaw.
]

{
	#category : #building,
	#'squeak_changestamp' : 'MCPServer 5/19/2026 13:11'
}
SRMenu >> rebuild [
	| rowY totalHeight |
	self children copy do: [:child | child remove].
	
	items ifEmpty: [slabHeight := 0. ^ self].
	
	totalHeight := items size * rowSpacing + (rowSpacing * 0.5).
	slabHeight := totalHeight.
	
	rowY := totalHeight / 2 - (rowSpacing * 0.75).
	
	items do: [:assoc |
		| menuItem |
		menuItem := SRMenuItem new
			label: assoc key action: assoc value;
			itemWidth: slabWidth - 0.01 height: rowSpacing * 0.85;
			position: 0 @ rowY @ (slabDepth / 2 + 0.002);
			yourself.
		self addChild: menuItem.
		rowY := rowY - rowSpacing].
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'MCPServer 5/19/2026 13:08'
}
SRMenu >> renderOn: aSRRenderer [
	slabHeight = 0 ifTrue: [^ self].
	Raylib rlPushMatrix;
		rlMultMatrixfMatf: self globalTransform transposed.
	Raylib
		drawCubePosition: (0 @ 0 @ 0) asRlVector
		width: slabWidth height: slabHeight length: slabDepth
		color: slabColor asRlColor.
	Raylib
		drawCubeWiresPosition: (0 @ 0 @ 0) asRlVector
		width: slabWidth height: slabHeight length: slabDepth
		color: wireColor asRlColor.
	Raylib rlPopMatrix.
]

{
	#category : #stepping,
	#'squeak_changestamp' : 'MCPServer 5/26/2026 17:44'
}
SRMenu >> step: deltaTime [
	"Update hover highlight on our own items by casting rays from each hand.
	Only walks our own item children -- no world-wide traversal."

	| avatar hands nearest nearestDist |
	self world ifNil: [^ self].
	avatar := self world avatar.
	avatar ifNil: [^ self].
	hands := {avatar leftHand. avatar rightHand} reject: [:h | h isNil].
	hands isEmpty ifTrue: [^ self].
	
	nearest := nil.
	nearestDist := nil.
	hands do: [:hand |
		| ray |
		ray := SRRay
			origin: hand globalTranslation
			forward: (hand globalTransform localDirToGlobal: Vector3 backward) normalize.
		self childrenDo: [:item |
			item isMenuItem ifTrue: [
				item collisionGeometry ifNotNil: [:geom |
					(geom rayIntersection: ray) ifNotNil: [:result |
						| dist |
						dist := ray origin distanceTo: result point.
						(nearestDist isNil or: [dist < nearestDist]) ifTrue: [
							nearestDist := dist.
							nearest := item]]]]]].
	
	"Update all items: only the nearest is hovered."
	self childrenDo: [:item |
		item isMenuItem ifTrue: [
			item hovered: (item == nearest)]]
]
