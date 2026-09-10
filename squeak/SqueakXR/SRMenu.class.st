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
		'submenuItem'
	],
	#category : #'SqueakXR-Objects',
	#'squeak_changestamp' : '<historical>'
}

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
	#'squeak_changestamp' : 'MCPServer 8/3/2026 14:38'
}
SRMenu class >> submenuSideOffset [
	"To the left of the opening menu, as a fraction of the menu width."

	^ 0.65
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
	#'squeak_changestamp' : 'MCPServer 8/3/2026 14:38'
}
SRMenu class >> xrMenuOpenBrowser: aMenu [
	<xrMenu: #(world tools) label: 'System Browser' priority: 220>
	^ Browser open
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
	#'squeak_changestamp' : 'MCPServer 8/3/2026 14:37'
}
SRMenu >> addItemsUnder: aPrefix target: anObjectOrNil [
	"Entries at aPrefix become rows, deeper paths one submenu row per group."

	| registry |
	registry := SRMenuRegistry current.
	(registry directItemsUnder: aPrefix) do: [:entry |
		self
			addItem: (entry labelIn: self target: anObjectOrNil)
			action: [entry activateIn: self target: anObjectOrNil]].
	(registry groupsUnder: aPrefix) do: [:segment |
		self addSubmenuItemFor: segment under: aPrefix target: anObjectOrNil]
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
	#'squeak_changestamp' : 'MCPServer 8/3/2026 14:38'
}
SRMenu >> closeCascade [
	self rootMenu remove.
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
	#category : #submenus,
	#'squeak_changestamp' : 'MCPServer 8/10/2026 13:54'
}
SRMenu >> openSubmenuFor: aPath target: anObjectOrNil fromItem: anItemOrNil [
	"Only one submenu is open at a time; hitting the same row again closes it."

	| sub reopening |
	reopening := submenu notNil and: [submenuItem == anItemOrNil].
	self closeSubmenu.
	reopening ifTrue: [^ nil].
	sub := self class new
		parentMenu: self;
		yourself.
	(self parent ifNil: [self world]) ifNotNil: [:container | container addChild: sub].
	sub addItemsUnder: aPath target: anObjectOrNil.
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
	#'squeak_changestamp' : 'MCPServer 8/3/2026 14:38'
}
SRMenu >> placeNextTo: aMenu atItem: anItemOrNil [
	"Offsets are in aMenu's own frame, so the submenu inherits its orientation."

	| topY offset |
	topY := anItemOrNil
		ifNil: [aMenu slabHeight / 2]
		ifNotNil: [:item | item localPosition y + (aMenu rowSpacing / 2)].
	offset := (aMenu slabWidth * self class submenuSideOffset) negated
		@ (topY - (self slabHeight / 2))
		@ self class submenuForwardOffset.
	self globalTransform: aMenu globalTransform * (Matrix4x4 withOffset: offset).
]

{
	#category : #building,
	#'squeak_changestamp' : 'MCPServer 8/3/2026 13:29'
}
SRMenu >> rebuild [
	| rowY totalHeight |
	self children copy do: [:child | child remove].
	
	items ifEmpty: [^ self].
	
	totalHeight := items size * rowSpacing + (rowSpacing * 0.5).
	slabSize y: totalHeight.
	
	rowY := totalHeight / 2 - (rowSpacing * 0.75).
	
	items do: [:spec |
		| menuItem |
		menuItem := SRMenuItem new
			label: spec first action: spec second;
			keepsMenuOpen: spec third;
			width: slabSize x - 0.01 height: rowSpacing * 0.85;
			position: 0 @ rowY @ (slabSize z / 2 + 0.002);
			yourself.
		self addChild: menuItem.
		rowY := rowY - rowSpacing].
	
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
	#category : #submenus,
	#'squeak_changestamp' : 'MCPServer 8/3/2026 13:29'
}
SRMenu >> rootMenu [
	^ parentMenu ifNil: [self] ifNotNil: [:p | p rootMenu]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 8/3/2026 13:28'
}
SRMenu >> rowSpacing [
	^ rowSpacing
]

{
	#category : #actions,
	#'squeak_changestamp' : 'MCPServer 8/3/2026 14:38'
}
SRMenu >> setTransformAt: aPosition facingCamera: aCamera [
	"Adopts the camera's viewing direction rather than turning towards the camera."

	| direction up |
	direction := aCamera forward.
	up := (direction dot: Vector3 up) abs > 0.99
		ifTrue: [aCamera up]	"looking straight up or down"
		ifFalse: [Vector3 up].
	self globalTransform: (Matrix4x4
		objectLookAt: aPosition - direction
		from: aPosition
		up: up)
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
	#'squeak_changestamp' : 'MCPServer 8/3/2026 13:31'
}
SRMenu >> step: deltaTime [
	"Update hover highlight on our own items by casting rays from each hand."

	| nearest |
	self world avatar hands do: [:hand | | |
		nearest := (hand rayBackward castNearestObjects: self children) ifNotNil: #object.
		
		self childrenDo: [:item |
			item isMenuItem ifTrue: [
				item hovered: (item == nearest or: [item == submenuItem])]]].
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
