"
3D menu panel with labeled items.
"
Class {
	#name : #SRMenu,
	#superclass : #SRObject,
	#instVars : [
		'items',
		'slabColor',
		'wireColor',
		'textScale',
		'rowSpacing',
		'slabSize'
	],
	#category : #'SqueakXR-Objects',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'lege 7/1/2026 18:25'
}
SRMenu class >> contextMenuFor: anObject at: aPosition facing: aViewerPosition in: aWorld [
	"aViewerPosition is the user's head/camera position; the menu will face it."
	| menu |
	menu := self new.
	
	menu
		addItem: 'Inspect'
		action: (MessageSend receiver: menu selector: #inspect: argument: anObject);
		addItem: 'Clone'
		action: (MessageSend receiver: menu selector: #clone: argument: anObject);
		addItem: 'Remove'
		action: (MessageSend receiver: menu selector: #remove: argument: anObject);
		yourself.
		
	anObject addCustomMenuItemsTo: menu.
	
	menu setTransformAt: aPosition facingViewer: aViewerPosition.
	aWorld addChild: menu.
	
	^ menu.
]

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'lege 7/1/2026 18:14'
}
SRMenu class >> worldMenuAt: aPosition facing: aViewerPosition in: aWorld [
	"aViewerPosition is the user's head/camera position; the menu will face it."
	| menu |
	menu := self new.
	menu
		addItem: 'Spawn Cube'
		action: (MessageSend receiver: menu selector: #spawnCube: argument: aPosition).
	(Smalltalk hasClassNamed: #SWAGameCube) ifTrue: [
		menu
			addItem: 'Spawn SWACube'
			action: (MessageSend receiver: menu selector: #spawnSWACube: argument: aPosition)].
	(Smalltalk hasClassNamed: #SWAGameXR) ifTrue: [
		menu
			addItem: 'Spawn SWAGame'
			action: (MessageSend receiver: menu selector: #spawnSWAGame: argument: aPosition)].
	menu
		addItem: 'Scene Tree'
		action: (MessageSend receiver: menu selector: #openSceneTreeInspector);
		addItem: 'Frame Time Graph'
		action: (MessageSend receiver: menu selector: #spawnFrameTimeGraph: argument: aPosition);
		addItem: (aWorld debugHUD
			ifNotNil: [:h | h visible ifTrue: ['Debug HUD: ON'] ifFalse: ['Debug HUD: OFF']]
			ifNil: ['Debug HUD: N/A'])
		action: (MessageSend receiver: menu selector: #toggleDebugHUD);
		addItem: (aWorld outOfBodyMode
			ifTrue: ['Return to Body']
			ifFalse: ['Out-of-Body Mode'])
		action: (MessageSend receiver: menu selector: #toggleOutOfBody).
	"(Smalltalk hasClassNamed: #SBMCPServer) ifTrue: [
		| mcp label |
		mcp := Smalltalk at: #SBMCPServer.
		label := (mcp current notNil and: [mcp current isRunning])
			ifTrue: ['MCP Server: ON']
			ifFalse: ['MCP Server: OFF'].
		menu addItem: label action: [mcp toggle]]."
	(Smalltalk hasClassNamed: #MCPLogger) ifTrue: [
		menu
			addItem: 'Open MCP Log'
			action: (MessageSend receiver: menu selector: #toggleMCPLogger)].
	menu
		addItem: 'Workspace'
		action: (MessageSend receiver: menu selector: #openWorkspace);
		addItem: 'System Browser'
		action: (MessageSend receiver: menu selector: #openBrowser).
		
	menu setTransformAt: aPosition facingViewer: aViewerPosition.
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
	#category : #'menu-actions',
	#'squeak_changestamp' : 'lege 7/1/2026 18:24'
}
SRMenu >> clone: anSRObject [
	
	| clone |
	clone := anSRObject veryDeepCopy.
	clone position: anSRObject position + (30cm @ 0 @ 0).
	anSRObject parent addChild: clone
]

{
	#category : #actions,
	#'squeak_changestamp' : 'lege 7/1/2026 15:37'
}
SRMenu >> close [

	self remove.
]

{
	#category : #collisions,
	#'squeak_changestamp' : 'lege 7/1/2026 18:49'
}
SRMenu >> collisionGeometry [
	slabSize y = 0 ifTrue: [^ nil].
	^ SRCollisionBox new
		center: self globalTranslation;
		halfExtents: self globalScale * slabSize / 2;
		rotation: self globalRotation;
		object: self.
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'lege 7/1/2026 18:48'
}
SRMenu >> initialize [
	super initialize.
	items := OrderedCollection new.
	slabSize := 15cm @ 0 @ 5mm.
	slabColor := Color r: 0.05 g: 0.05 b: 0.1.
	wireColor := Color r: 0.3 g: 0.3 b: 0.5.
	textScale := 0.015.
	rowSpacing := 0.025.
]

{
	#category : #'menu-actions',
	#'squeak_changestamp' : 'lege 7/1/2026 18:20'
}
SRMenu >> inspect: anObject [

	anObject inspect
]

{
	#category : #testing,
	#'squeak_changestamp' : 'MCPServer 5/19/2026 11:27'
}
SRMenu >> isMenu [
	^ true.
]

{
	#category : #testing,
	#'squeak_changestamp' : 'lege 7/1/2026 15:37'
}
SRMenu >> isOpen [

	^ self parent notNil
]

{
	#category : #'menu-actions',
	#'squeak_changestamp' : 'lege 7/1/2026 18:11'
}
SRMenu >> openBrowser [

	Browser open
]

{
	#category : #'menu-actions',
	#'squeak_changestamp' : 'lege 7/1/2026 18:00'
}
SRMenu >> openSceneTreeInspector [

	SRSceneTreeInspector openOn: self world
]

{
	#category : #'menu-actions',
	#'squeak_changestamp' : 'lege 7/1/2026 18:10'
}
SRMenu >> openWorkspace [

	Workspace open
]

{
	#category : #building,
	#'squeak_changestamp' : 'lege 7/1/2026 18:50'
}
SRMenu >> rebuild [
	| rowY totalHeight |
	self children copy do: [:child | child remove].
	
	items ifEmpty: [slabSize y: 0. ^ self].
	
	totalHeight := items size * rowSpacing + (rowSpacing * 0.5).
	slabSize y: totalHeight.
	
	rowY := totalHeight / 2 - (rowSpacing * 0.75).
	
	items do: [:assoc |
		| menuItem |
		menuItem := SRMenuItem new
			label: assoc key action: assoc value;
			itemWidth: slabSize x - 0.01 height: rowSpacing * 0.85;
			position: 0 @ rowY @ (slabSize z / 2 + 0.002);
			yourself.
		self addChild: menuItem.
		rowY := rowY - rowSpacing].
]

{
	#category : #'menu-actions',
	#'squeak_changestamp' : 'lege 7/1/2026 18:24'
}
SRMenu >> remove: anSRObject [
	
	anSRObject remove.
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'lege 7/1/2026 18:50'
}
SRMenu >> renderOn: aSRRenderer [
	slabSize y = 0 ifTrue: [^ self].
	Raylib rlPushMatrix;
		rlMultMatrixfMatf: self globalTransform transposed.
	Raylib
		drawCubePosition: (0 @ 0 @ 0) asRlVector
		width: slabSize x height: slabSize y length: slabSize z
		color: slabColor asRlColor.
	Raylib
		drawCubeWiresPosition: (0 @ 0 @ 0) asRlVector
		width: slabSize x height: slabSize y length: slabSize z
		color: wireColor asRlColor.
	Raylib rlPopMatrix.
]

{
	#category : #actions,
	#'squeak_changestamp' : 'lege 7/1/2026 18:12'
}
SRMenu >> setTransformAt: aPosition facingViewer: aViewerPosition [

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
	#category : #'menu-actions',
	#'squeak_changestamp' : 'lege 7/1/2026 17:51'
}
SRMenu >> spawnCube: aVector3 [

	self world addChild: (
		SRCube new
			position: aVector3;
			scale: 30cm asVector3)
]

{
	#category : #'menu-actions',
	#'squeak_changestamp' : 'lege 7/1/2026 18:02'
}
SRMenu >> spawnFrameTimeGraph: aVector3 [

	self world addChild: (
		SRFrameTimeGraph new
			position: aVector3;
			yourself)
]

{
	#category : #'menu-actions',
	#'squeak_changestamp' : 'lege 7/1/2026 17:54'
}
SRMenu >> spawnSWACube: aVector3 [

	self world addChild: (
		SWAGameCube new
			position: aVector3;
			scale: 10cm asVector3;
			color: Color green)
]

{
	#category : #'menu-actions',
	#'squeak_changestamp' : 'lege 7/1/2026 18:00'
}
SRMenu >> spawnSWAGame: aVector3 [

	| game |
	game := SWAGameXR new position: aVector3.
	self world addChild: game.
	game generateWorld.
]

{
	#category : #stepping,
	#'squeak_changestamp' : 'SqueakXR 6/26/2026 17:28'
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
				item collisionGeometryDo: [:geom |
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

{
	#category : #'menu-actions',
	#'squeak_changestamp' : 'lege 7/1/2026 18:06'
}
SRMenu >> toggleDebugHUD [

	self world debugHUD ifNotNil: [:h | h toggleVisibility]
]

{
	#category : #'menu-actions',
	#'squeak_changestamp' : 'lege 7/1/2026 18:09'
}
SRMenu >> toggleMCPLogger [

	(Smalltalk at: #MCPLogger) openLog
]

{
	#category : #'menu-actions',
	#'squeak_changestamp' : 'lege 7/1/2026 18:07'
}
SRMenu >> toggleOutOfBody [

	self world toggleOutOfBody
]
