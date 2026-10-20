"
A debugging frame marker: X red, Y green, Z blue, the positive half bright and the negative half dim, so an inverted axis cannot be mistaken for a rotated one.

Built from SRCubes because SRRenderer has no line primitive, and because an SRCube has no collision geometry -- axes ride on tracked objects and would otherwise sit permanently between a ray and the world.
"
Class {
	#name : #SRAxes,
	#superclass : #SRObject,
	#instVars : [
		'length'
	],
	#classVars : [
		'ShowAxes'
	],
	#category : #'SqueakXR-Objects',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/20/2026 18:03'
}
SRAxes class >> length: aNumber [

	^ self new length: aNumber; yourself
]

{
	#category : #preferences,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/20/2026 18:03'
}
SRAxes class >> showAxes [
	<preference: 'Debug axes'
		category: 'SqueakXR'
		description: 'Draw colour-coded X (red), Y (green) and Z (blue) axes at the world origin, on the avatar rig and on the camera, with the negative half of each axis dimmed. For comparing the flat and XR camera frames.'
		type: #Boolean>
	^ ShowAxes ifNil: [false]
]

{
	#category : #preferences,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/20/2026 18:03'
}
SRAxes class >> showAxes: aBoolean [

	ShowAxes := aBoolean.
	SRWorld current ifNotNil: [:world | world updateDebugAxes].
]

{
	#category : #menu,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/20/2026 18:08'
}
SRAxes class >> xrMenuToggle: aMenu [
	<xrMenu: #(world debug) label: #xrMenuToggleLabel: priority: 405>
	^ self showAxes: self showAxes not
]

{
	#category : #menu,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/20/2026 18:03'
}
SRAxes class >> xrMenuToggleLabel: aMenu [

	^ self showAxes
		ifTrue: ['Debug axes: ON']
		ifFalse: ['Debug axes: OFF']
]

{
	#category : #building,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/20/2026 18:02'
}
SRAxes >> addBar: aScale at: aTranslation color: aColor name: aString [
	"A bar of full extent aScale centred on aTranslation, so an extent of l centred at
	l/2 spans 0 to l."

	^ self addChild: (SRCube new
		color: aColor;
		scale: aScale;
		translation: aTranslation;
		name: aString;
		yourself)
]

{
	#category : #building,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/20/2026 18:11'
}
SRAxes >> barThickness [
	"Fixed rather than a fraction of the length, so a 10 m frame and a 1 m one draw
	with the same line weight. Below about 1mm the bars go sub-pixel at a distance
	and shimmer instead of reading as lines."

	^ 2mm
]

{
	#category : #building,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/20/2026 18:11'
}
SRAxes >> buildBars [

	| l t o |
	self childrenCopy do: [:each | each remove].
	l := length.
	t := self barThickness.
	o := t * 4.
	self addBar: o @ o @ o at: Vector3 zero color: Color white name: 'Origin'.
	self addBar: l @ t @ t at: (l / 2) @ 0 @ 0 color: Color red name: '+X'.
	self addBar: l @ t @ t at: (l / -2) @ 0 @ 0 color: (self dim: Color red) name: '-X'.
	self addBar: t @ l @ t at: 0 @ (l / 2) @ 0 color: Color green name: '+Y'.
	self addBar: t @ l @ t at: 0 @ (l / -2) @ 0 color: (self dim: Color green) name: '-Y'.
	self addBar: t @ t @ l at: 0 @ 0 @ (l / 2) color: Color blue name: '+Z'.
	self addBar: t @ t @ l at: 0 @ 0 @ (l / -2) color: (self dim: Color blue) name: '-Z'.
]

{
	#category : #building,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/20/2026 18:02'
}
SRAxes >> dim: aColor [

	^ aColor mixed: 0.3 with: Color black
]

{
	#category : #'initialize-release',
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/20/2026 18:02'
}
SRAxes >> initialize [

	super initialize.
	self name: 'SRAxes'.
	length := 50cm.
	self buildBars.
]

{
	#category : #testing,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/20/2026 18:02'
}
SRAxes >> isAxes [

	^ true
]

{
	#category : #testing,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/20/2026 18:02'
}
SRAxes >> isSolid [

	^ false
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/20/2026 18:02'
}
SRAxes >> length [

	^ length
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/20/2026 18:02'
}
SRAxes >> length: aNumber [

	length := aNumber.
	self buildBars.
]
