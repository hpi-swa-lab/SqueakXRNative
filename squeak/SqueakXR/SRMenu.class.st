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
		'needsRebuild',
		'parentMenu',
		'submenu',
		'submenuItem',
		'sticky',
		'lastPointedAt'
	],
	#category : #'SqueakXR-Objects',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 15:00'
}
SRMenu class >> appMenuFor: anApp at: aPosition facingCamera: aCamera in: aWorld [

	| menu |
	menu := self new.
	anApp addCustomMenuItemsTo: menu.
	menu setTransformAt: aPosition facingCamera: aCamera.
	aWorld addChild: menu.
	menu
		addItemsUnder: {anApp class name asSymbol} target: anApp;
		addSubmenuItemFor: #world under: #() target: nil.
	^ menu
]

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'MCPServer 8/3/2026 14:37'
}
SRMenu class >> contextMenuFor: anObject at: aPosition facingCamera: aCamera in: aWorld [
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

	menu setTransformAt: aPosition facingCamera: aCamera.
	aWorld addChild: menu.
	menu
		addItemsUnder: #(object) target: anObject;
		addItemsUnder: {anObject class name asSymbol} target: anObject.
	
	^ menu
]

{
	#category : #layout,
	#'squeak_changestamp' : 'MCPServer 8/3/2026 14:38'
}
SRMenu class >> submenuForwardOffset [
	^ 3cm
]

{
	#category : #building,
	#'squeak_changestamp' : 'MCPServer 8/3/2026 13:29'
}
SRMenu class >> submenuLabelFor: aSegment [
	^ aSegment asString capitalized , ' >'
]

{
	#category : #layout,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/27/2026 15:14'
}
SRMenu class >> submenuSideOffset [
	"To the right, leaving the start of the parent's left-aligned labels in view."

	^ 12cm
]

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'MCPServer 8/3/2026 14:37'
}
SRMenu class >> worldMenuAt: aPosition facingCamera: aCamera in: aWorld [
	"Rows come from the #xrMenu: registry, see SRMenuRegistry."
	| menu |
	menu := self new.
	menu setTransformAt: aPosition facingCamera: aCamera.
	aWorld addChild: menu.
	menu addItemsUnder: #(world) target: nil.
	^ menu
]

{
	#category : #'xr menu',
	#'squeak_changestamp' : 'leo 10/27/2026 18:14'
}
SRMenu class >> xrMenuOpenBrowser: aMenu [
	<xrMenu: #(world tools) label: 'System Browser' priority: 220>
	^ SystemBrowser default open
]

{
	#category : #'xr menu',
	#'squeak_changestamp' : 'MCPServer 8/3/2026 14:38'
}
SRMenu class >> xrMenuOpenWorkspace: aMenu [
	<xrMenu: #(world tools) label: 'Workspace' priority: 200>
	^ Workspace open
]

{
	#category : #sticky,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:45'
}
SRMenu >> addCloseButton [
	"Above the slab rather than in it: the rows fill the slab exactly, and a sticky
	menu is the only one that cannot be dismissed by picking something."

	self addChild: (SRMenuItem new
		width: 3cm height: 2cm;
		label: 'X' action: [self remove];
		position: slabSize x / 2 - 2cm @ (slabSize y / 2 + 1.5cm) @ (slabSize z / 2 + 0.002);
		yourself).
]

{
	#category : #building,
	#'squeak_changestamp' : 'MCPServer 8/3/2026 13:29'
}
SRMenu >> addItem: aString action: aBlock [

	self addItem: aString action: aBlock keepOpen: false.
]

{
	#category : #building,
	#'squeak_changestamp' : 'MCPServer 8/3/2026 15:55'
}
SRMenu >> addItem: aString action: anAction keepOpen: aBoolean [
	"anAction takes the activated SRMenuItem as an optional argument."

	items add: (Array with: aString with: anAction with: aBoolean).
	needsRebuild := true.
]

{
	#category : #building,
	#'squeak_changestamp' : 'MCPServer 10/16/2026 15:14'
}
SRMenu >> addItemsUnder: aPrefix target: anObjectOrNil [
	"Entries at aPrefix become rows, deeper paths one submenu row per group."

	| registry |
	registry := SRMenuRegistry current.
	(registry directItemsUnder: aPrefix) do: [:entry |
		self
			addItem: [entry labelIn: self target: anObjectOrNil]
			action: [entry activateIn: self target: anObjectOrNil.
				entry keepOpen ifTrue: [self labelsChanged]]
			keepOpen: entry keepOpen].
	(registry groupsUnder: aPrefix) do: [:segment |
		self addSubmenuItemFor: segment under: aPrefix target: anObjectOrNil]
]

{
	#category : #building,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 15:00'
}
SRMenu >> addSubmenuItemFor: aSegment filledBy: aBlock [

	self
		addItem: (self class submenuLabelFor: aSegment)
		action: [:item | self openSubmenuFromItem: item filledBy: aBlock]
		keepOpen: true.
]

{
	#category : #building,
	#'squeak_changestamp' : 'MCPServer 8/3/2026 14:37'
}
SRMenu >> addSubmenuItemFor: aSegment under: aPrefix target: anObjectOrNil [
	| subPath |
	subPath := aPrefix asArray copyWith: aSegment.
	self
		addItem: (self class submenuLabelFor: aSegment)
		action: [:item | self openSubmenuFor: subPath target: anObjectOrNil fromItem: item]
		keepOpen: true.
]

{
	#category : #building,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/27/2026 16:23'
}
SRMenu >> carryOverRowsFrom: oldRows [
	"Picking a row rebuilds the menu, and a new row object under an unmoved ray must
	not read as the ray arriving on another row."

	| newRows rowFor |
	newRows := self children select: [:child | child isMenuItem].
	rowFor := [:each | | index |
		index := oldRows indexOf: each.
		(index between: 1 and: newRows size)
			ifTrue: [newRows at: index]
			ifFalse: [each]].
	submenuItem ifNotNil: [submenuItem := rowFor value: submenuItem].
	lastPointedAt := IdentitySet withAll: (lastPointedAt asArray collect: rowFor).
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
	#category : #submenus,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:44'
}
SRMenu >> closeCascade [
	"Closing stops at the nearest sticky menu, which keeps its place and loses only
	whatever it had open below it."

	sticky ifTrue: [^ self closeSubmenu].
	parentMenu ifNil: [^ self remove].
	^ parentMenu closeCascade.
]

{
	#category : #submenus,
	#'squeak_changestamp' : 'MCPServer 8/3/2026 14:38'
}
SRMenu >> closeSubmenu [
	| sub |
	sub := submenu.
	submenu := nil.
	submenuItem := nil.
	sub ifNotNil: [sub remove].
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
	#category : #sticky,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:44'
}
SRMenu >> detachFromCascade [
	"Unlink first, so closing the parents does not take this menu down with them."

	| p |
	p := parentMenu ifNil: [^ self].
	parentMenu := nil.
	p submenuWasRemoved: self.
	p closeCascade.
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/27/2026 15:14'
}
SRMenu >> initialize [
	super initialize.
	items := OrderedCollection new.
	slabSize := 30cm @ 0 @ 5mm.
	slabColor := Color r: 0.05 g: 0.05 b: 0.1.
	wireColor := Color r: 0.3 g: 0.3 b: 0.5.
	rowSpacing := 2.5cm.
	needsRebuild := false.
	sticky := false.
	lastPointedAt := IdentitySet new.
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
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/20/2026 13:26'
}
SRMenu >> isSolid [
	^ false
]

{
	#category : #sticky,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:44'
}
SRMenu >> isSticky [
	^ sticky.
]

{
	#category : #building,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:37'
}
SRMenu >> labelFrom: aStringOrBlock [
	"Registry rows keep their label as a block, so a toggle row in a sticky menu
	shows its new state without the menu having to be reopened."

	^ aStringOrBlock isString
		ifTrue: [aStringOrBlock]
		ifFalse: [aStringOrBlock value].
]

{
	#category : #building,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:37'
}
SRMenu >> labelsChanged [
	needsRebuild := true.
]

{
	#category : #events,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:44'
}
SRMenu >> onGrabStarted: aHand [
	"Anyone who bothers to move a menu wants that menu and nothing above it."

	self sticky: true.
	self detachFromCascade.
]

{
	#category : #submenus,
	#'squeak_changestamp' : 'MCPServer (jl) 10/21/2026 11:22'
}
SRMenu >> openSubmenuFor: aPath target: anObjectOrNil fromItem: anItemOrNil [
	^ self
		openSubmenuFromItem: anItemOrNil
		filledBy: [:sub | sub addItemsUnder: aPath target: anObjectOrNil]
]

{
	#category : #submenus,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 15:00'
}
SRMenu >> openSubmenuFromItem: anItemOrNil filledBy: aBlock [

	| sub reopening |
	reopening := submenu notNil and: [submenuItem == anItemOrNil].
	self closeSubmenu.
	reopening ifTrue: [^ nil].
	sub := self class new
		parentMenu: self;
		yourself.
	(self parent ifNil: [self world]) ifNotNil: [:container | container addChild: sub].
	aBlock value: sub.
	sub rebuild.
	sub placeNextTo: self atItem: anItemOrNil.
	submenu := sub.
	submenuItem := anItemOrNil.
	^ sub
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 8/3/2026 14:37'
}
SRMenu >> parentMenu [
	^ parentMenu
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 8/3/2026 13:28'
}
SRMenu >> parentMenu: aSRMenuOrNil [
	parentMenu := aSRMenuOrNil.
]

{
	#category : #submenus,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/27/2026 15:14'
}
SRMenu >> placeNextTo: aMenu atItem: anItemOrNil [
	"Offsets are in aMenu's own frame, so the submenu inherits its orientation. It drops
	below the parent's top only as far as needed to cover the opening row, so the ray
	reaches it from that row without crossing another one."

	| topY offset |
	topY := aMenu slabHeight / 2.
	anItemOrNil ifNotNil: [:item |
		topY := topY min: item localPosition y - (aMenu rowSpacing / 2) + self slabHeight].
	offset := self class submenuSideOffset
		@ (topY - (self slabHeight / 2))
		@ self class submenuForwardOffset.
	self globalTransform: aMenu globalTransform * (Matrix4x4 withOffset: offset).
]

{
	#category : #submenus,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/27/2026 15:14'
}
SRMenu >> pointableObjects [
	"The open cascade is included so that a row hidden behind a submenu is not pointed at."

	| objects menu |
	objects := self children copy.
	menu := submenu.
	[menu notNil] whileTrue: [
		objects add: menu.
		menu := menu submenu].
	^ objects
]

{
	#category : #stepping,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/27/2026 15:14'
}
SRMenu >> pointedAt: aSet [
	"Only a ray arriving on another row closes the submenu: a hand left resting on this
	menu must not close what the other hand has just opened."

	| arrived |
	arrived := aSet reject: [:each | lastPointedAt includes: each].
	(submenu notNil and: [arrived anySatisfy: [:each |
			each isMenuItem and: [each ~~ submenuItem]]])
		ifTrue: [self closeSubmenu].
	lastPointedAt := aSet.
	self setHoveredItems: (submenuItem
		ifNil: [aSet]
		ifNotNil: [:item | aSet copyWith: item]).
]

{
	#category : #building,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/27/2026 16:23'
}
SRMenu >> rebuild [
	| rowY totalHeight oldRows |
	oldRows := self children select: [:child | child isMenuItem].
	self children copy do: [:child | child remove].
	
	items ifEmpty: [^ self].
	
	totalHeight := items size * rowSpacing + (rowSpacing * 0.5).
	slabSize y: totalHeight.
	
	rowY := totalHeight / 2 - (rowSpacing * 0.75).
	
	items do: [:spec |
		| menuItem |
		menuItem := SRMenuItem new
			width: slabSize x - 0.01 height: rowSpacing * 0.85;
			label: (self labelFrom: spec first) action: spec second;
			keepsMenuOpen: spec third;
			position: 0 @ rowY @ (slabSize z / 2 + 0.002);
			yourself.
		self addChild: menuItem.
		rowY := rowY - rowSpacing].
	
	sticky ifTrue: [self addCloseButton].
	self carryOverRowsFrom: oldRows.
	needsRebuild := false.
]

{
	#category : #submenus,
	#'squeak_changestamp' : 'MCPServer 8/3/2026 14:38'
}
SRMenu >> remove [
	self closeSubmenu.
	parentMenu ifNotNil: [:p | parentMenu := nil. p submenuWasRemoved: self].
	super remove.
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
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 8/3/2026 13:28'
}
SRMenu >> rowSpacing [
	^ rowSpacing
]

{
	#category : #stepping,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 15:00'
}
SRMenu >> setHoveredItems: aCollection [

	self childrenDo: [:item |
		item isMenuItem ifTrue: [item hovered: (aCollection includes: item)]].
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 8/3/2026 14:37'
}
SRMenu >> slabHeight [
	"Only valid after #rebuild."

	^ slabSize y
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 8/3/2026 13:28'
}
SRMenu >> slabWidth [
	^ slabSize x
]

{
	#category : #stepping,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/27/2026 15:14'
}
SRMenu >> step: deltaTime [

	| avatar hovered |
	avatar := self world ifNotNil: [:w | w avatar].
	avatar ifNil: [^ self].
	hovered := IdentitySet new.
	avatar hands do: [:hand |
		(hand rayForward castNearestObjects: self pointableObjects)
			ifNotNil: [:result | hovered add: result object]].
	self pointedAt: hovered.
]

{
	#category : #sticky,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:35'
}
SRMenu >> sticky: aBoolean [
	sticky = aBoolean ifTrue: [^ self].
	sticky := aBoolean.
	needsRebuild := true.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 8/3/2026 14:37'
}
SRMenu >> submenu [
	^ submenu
]

{
	#category : #submenus,
	#'squeak_changestamp' : 'MCPServer 8/3/2026 13:31'
}
SRMenu >> submenuWasRemoved: aMenu [
	submenu == aMenu ifTrue: [submenu := nil. submenuItem := nil].
]

{
	#category : #testing,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 15:00'
}
SRMenu >> travelsWithAvatar [

	^ true
]
