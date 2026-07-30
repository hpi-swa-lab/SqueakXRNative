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
	#classVars : [
		'Registry'
	],
	#category : #'SqueakXR-Objects',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #registry,
	#'squeak_changestamp' : 'MCPServer 7/30/2026 15:37'
}
SRMenu class >> buildRegistry [
	"Scan the image for <srMenu: #(path) label: 'x' priority: n> on class side methods.
	Call this at world start, or again after loading new code."
	| found |
	found := OrderedCollection new.
	Smalltalk allClassesDo: [:aClass |
		aClass class methodsDo: [:method |
			method pragmasDo: [:p |
				(#(#srMenu:label: #srMenu:label:priority:) includes: p keyword) ifTrue: [
					found add: {
						(p argumentAt: 1) asArray.
						p argumentAt: 2.
						p arguments size >= 3 ifTrue: [p argumentAt: 3] ifFalse: [500].
						p methodClass theNonMetaClass.
						p selector}]]]].
	^ Registry := found asArray sort: [:a :b |
		(self pathString: a first) = (self pathString: b first)
			ifTrue: [a third = b third
				ifTrue: [a second asString <= b second asString]
				ifFalse: [a third < b third]]
			ifFalse: [(self pathString: a first) <= (self pathString: b first)]]
]

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'MCPServer 7/30/2026 16:44'
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
	menu
		addItemsUnder: #(object) target: anObject;
		addItemsUnder: {anObject class name asSymbol} target: anObject.
	
	^ menu.
]

{
	#category : #registry,
	#'squeak_changestamp' : 'MCPServer 7/30/2026 15:37'
}
SRMenu class >> itemsUnder: aPrefix [
	| prefix |
	prefix := aPrefix asArray.
	^ self registry select: [:each |
		prefix size <= each first size
			and: [(each first first: prefix size) = prefix]]
]

{
	#category : #registry,
	#'squeak_changestamp' : 'MCPServer 7/30/2026 15:37'
}
SRMenu class >> pathString: aPath [
	^ String streamContents: [:s |
		aPath do: [:each | s nextPutAll: each asString] separatedBy: [s nextPut: $/]]
]

{
	#category : #registry,
	#'squeak_changestamp' : 'MCPServer 7/30/2026 15:37'
}
SRMenu class >> registry [
	^ Registry ifNil: [self buildRegistry]
]

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'MCPServer 7/30/2026 16:44'
}
SRMenu class >> worldMenuAt: aPosition facing: aViewerPosition in: aWorld [
	"aViewerPosition is the user's head/camera position; the menu will face it."
	| menu |
	menu := self new.
	menu
		addItem: 'Scene Tree'
		action: (MessageSend receiver: menu selector: #openSceneTreeInspector).
	aWorld debugHUD ifNotNil: [
		menu
			addItem: (aWorld debugHUD visible ifTrue: ['Debug HUD: ON'] ifFalse: ['Debug HUD: OFF'])
			action: (MessageSend receiver: menu selector: #toggleDebugHUD)].
	menu addItem: (aWorld avatar isOutOfBody
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
	menu addItemsUnder: #(world) target: nil.
	
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
	#category : #building,
	#'squeak_changestamp' : 'MCPServer 7/30/2026 16:44'
}
SRMenu >> addItemsUnder: aPrefix target: anObjectOrNil [
	(self class itemsUnder: aPrefix) do: [:entry |
		self
			addItem: (self labelFor: entry under: aPrefix target: anObjectOrNil)
			action: [entry fourth perform: entry fifth withEnoughArguments: {self. anObjectOrNil}]]
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
	#category : #building,
	#'squeak_changestamp' : 'MCPServer 7/30/2026 16:44'
}
SRMenu >> labelFor: entry under: aPrefix target: anObjectOrNil [
	"Symbol labels are computed by the provider, for toggles. Groups are flattened
	into a label prefix until SRMenu has real submenus."
	| label |
	label := entry second isSymbol
		ifTrue: [(entry fourth perform: entry second withEnoughArguments: {self. anObjectOrNil}) asString]
		ifFalse: [entry second asString].
	^ String streamContents: [:s |
		(entry first allButFirst: aPrefix size) do: [:each |
			s nextPutAll: each asString capitalized; nextPutAll: ': '].
		s nextPutAll: label]
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
	#'squeak_changestamp' : 'lege 7/3/2026 18:24'
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
			width: slabSize x - 0.01 height: rowSpacing * 0.85;
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
	#'squeak_changestamp' : 'lege 7/20/2026 17:52'
}
SRMenu >> toggleOutOfBody [

	self world avatar toggleOutOfBody
]
