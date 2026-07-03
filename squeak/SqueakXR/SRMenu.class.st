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
		'rowSpacing',
		'slabSize',
		'needsRebuild'
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
	#'squeak_changestamp' : 'lege 7/3/2026 16:33'
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
		action: (MessageSend receiver: menu selector: #spawnFrameTimeGraph: argument: aPosition).
	aWorld debugHUD ifNotNil: [
		menu
			addItem: (aWorld debugHUD visible ifTrue: ['Debug HUD: ON'] ifFalse: ['Debug HUD: OFF'])
			action: (MessageSend receiver: menu selector: #toggleDebugHUD)].
	menu addItem: (aWorld outOfBodyMode
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
	#'squeak_changestamp' : 'lege 7/3/2026 16:40'
}
SRMenu >> addItem: aString action: aBlock [

	items add: (Association key: aString value: aBlock).
	needsRebuild := true.
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
	#'squeak_changestamp' : 'lege 7/3/2026 16:56'
}
SRMenu >> initialize [
	super initialize.
	items := OrderedCollection new.
	slabSize := 15cm @ 0 @ 5mm.
	slabColor := Color r: 0.05 g: 0.05 b: 0.1.
	wireColor := Color r: 0.3 g: 0.3 b: 0.5.
	rowSpacing := 2.5cm.
	needsRebuild := false.
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
	#'squeak_changestamp' : 'lege 7/3/2026 16:40'
}
SRMenu >> rebuild [
	| rowY totalHeight |
	self children copy do: [:child | child remove].
	
	items ifEmpty: [^ self].
	
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
	
	needsRebuild := false.
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
	#'squeak_changestamp' : 'lege 7/3/2026 17:17'
}
SRMenu >> renderOn: aSRRenderer [

	| transform |
	items ifEmpty: [^ self].
	needsRebuild ifTrue: [self rebuild].
	
	transform := self globalTransform * (Matrix4x4 withScale: slabSize).
	
	aSRRenderer
		renderPlainCubeTransformed: transform withColor: slabColor;
		renderWireCubeTransformed: transform withColor: wireColor.
]

{
	#category : #actions,
	#'squeak_changestamp' : 'lege 7/3/2026 15:54'
}
SRMenu >> setTransformAt: aPosition facingViewer: aViewerPosition [

	self globalTranslation: aPosition;
		lookAt: aViewerPosition.
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
	#'squeak_changestamp' : 'lege 7/3/2026 18:08'
}
SRMenu >> step: deltaTime [
	"Update hover highlight on our own items by casting rays from each hand."

	| nearest |
	self world avatar hands do: [:hand | | |
		nearest := (hand rayBackward castNearestObjects: self children) ifNotNil: #object.
		
		self childrenDo: [:item |
			item isMenuItem ifTrue: [
				item hovered: (item == nearest)]]].
]

{
	#category : #'menu-actions',
	#'squeak_changestamp' : 'lege 7/3/2026 16:34'
}
SRMenu >> toggleDebugHUD [

	self world debugHUD toggleVisibility.
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
