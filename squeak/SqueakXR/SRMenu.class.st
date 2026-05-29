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
	#'squeak_changestamp' : 'MCPServer 5/29/2026 14:08'
}
SRMenu class >> contextMenuFor: anObject at: aPosition facing: aDirection in: aWorld [
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
	menu openAt: aPosition facing: aDirection.
	aWorld addChild: menu.
	^ menu.
]

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'MCPServer 5/19/2026 13:32'
}
SRMenu class >> worldMenuAt: aPosition facing: aDirection in: aWorld [
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
	menu addItem: 'Workspace' action: [
		Workspace open].
	menu addItem: 'System Browser' action: [
		Browser open].
	menu openAt: aPosition facing: aDirection.
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
	#'squeak_changestamp' : 'MCPServer 5/19/2026 13:23'
}
SRMenu >> openAt: aPosition facing: aForwardDirection [
	"Position the menu at aPosition, rotated so its front face (+Z) points back at the viewer.
	aForwardDirection is the direction the hand points (away from viewer)."
	| flat |
	self position: aPosition.
	flat := (aForwardDirection x @ 0 @ aForwardDirection z) safelyNormalize.
	flat isZero ifTrue: [^ self].
	self rotation: (Quaternion new from: Vector3 forward to: flat negated).
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
