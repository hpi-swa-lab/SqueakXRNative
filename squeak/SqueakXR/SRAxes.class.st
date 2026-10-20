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
	#'squeak_changestamp' : 'MCPServer (jl) 10/20/2026 18:43'
}
SRAxes >> addLabel: aString at: aTranslation color: aColor name: aName [

	^ self addChild: (SRTextField new
		text: aString;
		color: aColor;
		scale: self labelSize asVector3;
		rotation: self labelRotation;
		translation: aTranslation;
		name: aName;
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
	#'squeak_changestamp' : 'MCPServer (jl) 10/20/2026 18:43'
}
SRAxes >> buildAxis: anAxis letter: aString labelOffset: anOffset color: aColor name: aName [

	| extent |
	extent := self extentAlong: anAxis.
	self addBar: extent at: anAxis * (length / 2) color: aColor name: '+' , aName.
	self addBar: extent at: anAxis * (length / -2) color: (self dim: aColor) name: '-' , aName.
	self
		addLabel: aString
		at: anAxis * (length + (self labelSize * 2))
		color: aColor
		name: 'Letter' , aName.
	1 to: length truncated do: [:metre |
		self
			addLabel: metre printString
			at: (anAxis * metre) + (anOffset * (self labelSize * 1.5))
			color: aColor
			name: aName , metre printString].
]

{
	#category : #building,
	#'squeak_changestamp' : 'MCPServer (jl) 10/20/2026 18:42'
}
SRAxes >> buildBars [

	"The axes are written as literal 1@0@0, 0@1@0, 0@0@1 rather than Vector3 right,
	up and forward. Those names are the thing under investigation: #right answers
	column 1, which in a proper rotation with column 3 forward is the *left*
	direction. Drawing the basis by its names would assume the answer."

	| o |
	self childrenCopy do: [:each | each remove].
	o := self barThickness * 4.
	self addBar: o @ o @ o at: 0 @ 0 @ 0 color: Color white name: 'Origin'.
	self buildAxis: 1 @ 0 @ 0 letter: 'x' labelOffset: 0 @ 1 @ 0 color: Color red name: 'X'.
	self buildAxis: 0 @ 1 @ 0 letter: 'y' labelOffset: 1 @ 0 @ 0 color: Color green name: 'Y'.
	self buildAxis: 0 @ 0 @ 1 letter: 'z' labelOffset: 0 @ 1 @ 0 color: Color blue name: 'Z'.
]

{
	#category : #building,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/20/2026 18:02'
}
SRAxes >> dim: aColor [

	^ aColor mixed: 0.3 with: Color black
]

{
	#category : #building,
	#'squeak_changestamp' : 'MCPServer (jl) 10/20/2026 18:43'
}
SRAxes >> extentAlong: anAxis [
	"Full length along anAxis, bar thickness on the other two."

	| t |
	t := self barThickness.
	^ (anAxis * (length - t)) + (t @ t @ t)
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
	#category : #building,
	#'squeak_changestamp' : 'MCPServer (jl) 10/20/2026 18:43'
}
SRAxes >> labelRotation [
	"DrawText3D lays glyphs flat in the XZ plane, where they are legible only from
	directly above. A quarter turn about X stands them upright, as SRMenuItem and
	SRActionSign both do."

	^ Quaternion new radiansAngle: Float pi / 2 axis: 1 @ 0 @ 0
]

{
	#category : #building,
	#'squeak_changestamp' : 'MCPServer (jl) 10/20/2026 18:43'
}
SRAxes >> labelSize [

	^ length / 50
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
