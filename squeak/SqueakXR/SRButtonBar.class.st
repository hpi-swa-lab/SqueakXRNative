"
A row of buttons that stays open. An SRMenu closes its cascade or opens submenus when picked; these buttons only run their action.
"
Class {
	#name : #SRButtonBar,
	#superclass : #SRObject,
	#instVars : [
		'slabSize'
	],
	#category : #'SqueakXR-Objects',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #building,
	#'squeak_changestamp' : 'jl-MCPServer 11/27/2026 15:25'
}
SRButtonBar >> addButton: aString action: aBlock [
	"aBlock takes the button and the picking hand as optional arguments."
	| button |
	button := SRButtonBarButton new
		label: aString action: aBlock;
		yourself.
	self addChild: button.
	self layoutButtons.
	^ button
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'jl-MCPServer 11/27/2026 15:25'
}
SRButtonBar >> buttons [
	^ self children select: [:each | each isMenuItem]
]

{
	#category : #collision,
	#'squeak_changestamp' : 'jl-MCPServer 11/27/2026 15:25'
}
SRButtonBar >> collisionGeometry [
	self buttons ifEmpty: [^ nil].
	^ SRCollisionBox new
		center: self globalTranslation;
		halfExtents: self globalScale * slabSize / 2;
		rotation: self globalRotation;
		object: self.
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'jl-MCPServer 11/27/2026 15:25'
}
SRButtonBar >> initialize [
	super initialize.
	slabSize := 0 @ 4cm @ 5mm.
]

{
	#category : #building,
	#'squeak_changestamp' : 'jl-MCPServer 11/27/2026 15:25'
}
SRButtonBar >> layoutButtons [
	| gap x |
	gap := 6mm.
	self buttons do: [:each | each width: each naturalWidth height: slabSize y - gap].
	slabSize x: (self buttons inject: gap into: [:sum :each | sum + each width + gap]).
	x := slabSize x / -2 + gap.
	self buttons do: [:each |
		each position: x + (each width / 2) @ 0 @ (slabSize z / 2 + 2mm).
		x := x + each width + gap].
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'jl-MCPServer 11/27/2026 15:25'
}
SRButtonBar >> renderOn: aSRRenderer [
	| transform |
	self buttons ifEmpty: [^ self].
	transform := self globalTransform * (Matrix4x4 withScale: slabSize).
	aSRRenderer
		renderPlainCubeTransformed: transform withColor: (Color r: 0.05 g: 0.05 b: 0.1);
		renderWireCubeTransformed: transform withColor: (Color r: 0.3 g: 0.3 b: 0.5).
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'jl-MCPServer 11/27/2026 15:25'
}
SRButtonBar >> slabHeight [
	^ slabSize y
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'jl-MCPServer 11/27/2026 15:25'
}
SRButtonBar >> slabWidth [
	^ slabSize x
]

{
	#category : #grabbing,
	#'squeak_changestamp' : 'jl-MCPServer 11/27/2026 15:25'
}
SRButtonBar >> wantsGrab [
	^ true
]
