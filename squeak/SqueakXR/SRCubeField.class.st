"
The cube fixture of SRCubeRenderBenchmark, left standing so you can walk into
it and watch the frame rate yourself instead of reading a table. The cubes are
a lattice starting 2 m in front of the origin; the remove sign sits between you
and it, because a world at 12 fps is a world you do not want to open a menu in.

One field at a time: SRCubeField class>>show: takes the previous one down.
"
Class {
	#name : #SRCubeField,
	#superclass : #SRObject,
	#instVars : [
		'cubeClass',
		'count',
		'button',
		'animating',
		'angle',
		'axis'
	],
	#classVars : [
		'Animating',
		'CubeClass',
		'DrawWires'
	],
	#category : #'SqueakXR-Benchmarks',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:36'
}
SRCubeField class >> animating [
	^ Animating ifNil: [Animating := false].
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 17:27'
}
SRCubeField class >> animating: aBoolean [
	Animating := aBoolean.
	self current ifNotNil: [:field | field animating: aBoolean].
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:10'
}
SRCubeField class >> cubeClass [
	^ CubeClass ifNil: [CubeClass := SRCube].
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:10'
}
SRCubeField class >> cubeClass: aClass [
	CubeClass := aClass.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 17:26'
}
SRCubeField class >> current [
	"No singleton: the running world owns the field, so a stopped world takes it with it."

	^ SRWorld current ifNotNil: [:world |
		world allDescendantsDetect: [:each | each isCubeField] ifNone: [nil]]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:36'
}
SRCubeField class >> drawWires [
	^ DrawWires ifNil: [DrawWires := true].
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 17:27'
}
SRCubeField class >> drawWires: aBoolean [
	DrawWires := aBoolean.
	self current ifNotNil: [:field | field drawWires: aBoolean].
]

{
	#category : #showing,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 17:27'
}
SRCubeField class >> removeCurrent [
	| field world |
	field := self current ifNil: [^ self].
	world := field world ifNil: [^ self].
	world addDeferredFrameMessage: [world removeChild: field].
]

{
	#category : #showing,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 17:27'
}
SRCubeField class >> show: aCount [
	| world field |
	world := SRWorld current ifNil: [^ nil].
	self removeCurrent.
	field := self new setCount: aCount cubeClass: self cubeClass.
	world addDeferredFrameMessage: [world addChild: field].
	^ field.
]

{
	#category : #menu,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:37'
}
SRCubeField class >> xrMenuAnimationLabel [
	^ 'animate: ' , (self animating ifTrue: ['on'] ifFalse: ['off'])
]

{
	#category : #menu,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:11'
}
SRCubeField class >> xrMenuClassLabel [
	^ 'class: ' , self cubeClass name
]

{
	#category : #menu,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:11'
}
SRCubeField class >> xrMenuRemove: aMenu [
	<xrMenu: #(world profile benchmarks cubes) label: 'remove' priority: 200>
	self removeCurrent.
]

{
	#category : #menu,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 18:53'
}
SRCubeField class >> xrMenuShow10000: aMenu [
	<xrMenu: #(world profile benchmarks cubes) label: '10000' priority: 39>
	^ self show: 10000
]

{
	#category : #menu,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 18:53'
}
SRCubeField class >> xrMenuShow1000: aMenu [
	<xrMenu: #(world profile benchmarks cubes) label: '1000' priority: 30>
	^ self show: 1000
]

{
	#category : #menu,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 18:53'
}
SRCubeField class >> xrMenuShow100: aMenu [
	<xrMenu: #(world profile benchmarks cubes) label: '100' priority: 21>
	^ self show: 100
]

{
	#category : #menu,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 18:53'
}
SRCubeField class >> xrMenuShow2000: aMenu [
	<xrMenu: #(world profile benchmarks cubes) label: '2000' priority: 31>
	^ self show: 2000
]

{
	#category : #menu,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 18:53'
}
SRCubeField class >> xrMenuShow200: aMenu [
	<xrMenu: #(world profile benchmarks cubes) label: '200' priority: 22>
	^ self show: 200
]

{
	#category : #menu,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 18:53'
}
SRCubeField class >> xrMenuShow3000: aMenu [
	<xrMenu: #(world profile benchmarks cubes) label: '3000' priority: 32>
	^ self show: 3000
]

{
	#category : #menu,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 18:53'
}
SRCubeField class >> xrMenuShow300: aMenu [
	<xrMenu: #(world profile benchmarks cubes) label: '300' priority: 23>
	^ self show: 300
]

{
	#category : #menu,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 18:53'
}
SRCubeField class >> xrMenuShow4000: aMenu [
	<xrMenu: #(world profile benchmarks cubes) label: '4000' priority: 33>
	^ self show: 4000
]

{
	#category : #menu,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 18:53'
}
SRCubeField class >> xrMenuShow400: aMenu [
	<xrMenu: #(world profile benchmarks cubes) label: '400' priority: 24>
	^ self show: 400
]

{
	#category : #menu,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 18:53'
}
SRCubeField class >> xrMenuShow5000: aMenu [
	<xrMenu: #(world profile benchmarks cubes) label: '5000' priority: 34>
	^ self show: 5000
]

{
	#category : #menu,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 18:53'
}
SRCubeField class >> xrMenuShow500: aMenu [
	<xrMenu: #(world profile benchmarks cubes) label: '500' priority: 25>
	^ self show: 500
]

{
	#category : #menu,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 18:53'
}
SRCubeField class >> xrMenuShow6000: aMenu [
	<xrMenu: #(world profile benchmarks cubes) label: '6000' priority: 35>
	^ self show: 6000
]

{
	#category : #menu,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 18:53'
}
SRCubeField class >> xrMenuShow600: aMenu [
	<xrMenu: #(world profile benchmarks cubes) label: '600' priority: 26>
	^ self show: 600
]

{
	#category : #menu,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 18:53'
}
SRCubeField class >> xrMenuShow7000: aMenu [
	<xrMenu: #(world profile benchmarks cubes) label: '7000' priority: 36>
	^ self show: 7000
]

{
	#category : #menu,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 18:53'
}
SRCubeField class >> xrMenuShow700: aMenu [
	<xrMenu: #(world profile benchmarks cubes) label: '700' priority: 27>
	^ self show: 700
]

{
	#category : #menu,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 18:53'
}
SRCubeField class >> xrMenuShow8000: aMenu [
	<xrMenu: #(world profile benchmarks cubes) label: '8000' priority: 37>
	^ self show: 8000
]

{
	#category : #menu,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 18:53'
}
SRCubeField class >> xrMenuShow800: aMenu [
	<xrMenu: #(world profile benchmarks cubes) label: '800' priority: 28>
	^ self show: 800
]

{
	#category : #menu,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 18:53'
}
SRCubeField class >> xrMenuShow9000: aMenu [
	<xrMenu: #(world profile benchmarks cubes) label: '9000' priority: 38>
	^ self show: 9000
]

{
	#category : #menu,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 18:53'
}
SRCubeField class >> xrMenuShow900: aMenu [
	<xrMenu: #(world profile benchmarks cubes) label: '900' priority: 29>
	^ self show: 900
]

{
	#category : #menu,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:37'
}
SRCubeField class >> xrMenuToggleAnimation: aMenu [
	<xrMenu: #(world profile benchmarks cubes) label: #xrMenuAnimationLabel priority: 12>
	self animating: self animating not.
]

{
	#category : #menu,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:11'
}
SRCubeField class >> xrMenuToggleClass: aMenu [
	<xrMenu: #(world profile benchmarks cubes) label: #xrMenuClassLabel priority: 10>
	self cubeClass: (self cubeClass == SRCube ifTrue: [SRFastCube] ifFalse: [SRCube]).
	self current ifNotNil: [:field | self show: field count].
]

{
	#category : #menu,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:37'
}
SRCubeField class >> xrMenuToggleWires: aMenu [
	<xrMenu: #(world profile benchmarks cubes) label: #xrMenuWiresLabel priority: 11>
	self drawWires: self drawWires not.
]

{
	#category : #menu,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:37'
}
SRCubeField class >> xrMenuWiresLabel [
	^ 'wires: ' , (self drawWires ifTrue: ['on'] ifFalse: ['off'])
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:36'
}
SRCubeField >> animating [
	^ animating.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:36'
}
SRCubeField >> animating: aBoolean [
	animating := aBoolean.
]

{
	#category : #building,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:11'
}
SRCubeField >> buildButton [
	button := SRActionSign new
		name: 'RemoveCubeField';
		slabColor: (Color r: 0.05 g: 0.3 b: 0.15);
		label: 'remove ' , count printString , ' ' , cubeClass name;
		position: 0 @ 1.4m @ -1.2m;
		action: [SRCubeField removeCurrent];
		yourself.
	self addChild: button.
]

{
	#category : #building,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:11'
}
SRCubeField >> buildCubes [
	"A lattice 1 m apart and 20 cm per cube, so there is room to walk between them."

	| side |
	side := (count raisedTo: 1 / 3) ceiling max: 1.
	self addChildren: ((1 to: count) collect: [:i | | n |
		n := i - 1.
		cubeClass new
			color: (Color h: i * 360 / count s: 0.7 v: 0.9);
			scale: 20cm asVector3;
			position: (n \\ side - (side / 2)) * 1m
					@ (n // side \\ side * 1m + 30cm)
					@ (0 - 2m - (n // (side * side) * 1m));
			yourself]).
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:11'
}
SRCubeField >> button [
	^ button.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:11'
}
SRCubeField >> count [
	^ count.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:11'
}
SRCubeField >> cubeClass [
	^ cubeClass.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:36'
}
SRCubeField >> drawWires: aBoolean [
	self childrenDo: [:each |
		each isCube ifTrue: [each drawWires: aBoolean]].
]

{
	#category : #initializing,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:36'
}
SRCubeField >> initialize [
	super initialize.
	animating := false.
	angle := 0.
	axis := (Vector3 x: 0.3 y: 1 z: 0.2) normalized.
]

{
	#category : #testing,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 17:26'
}
SRCubeField >> isCubeField [

	^ true
]

{
	#category : #building,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:37'
}
SRCubeField >> setCount: aCount cubeClass: aClass [
	count := aCount.
	cubeClass := aClass.
	self name: aCount printString , ' ' , aClass name.
	self buildCubes; buildButton.
	self drawWires: self class drawWires.
	animating := self class animating.
]

{
	#category : #stepping,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:36'
}
SRCubeField >> step: deltaTime [
	"One step for the whole field rather than one per cube: N cubes stepping
	themselves is N entries in the frame's stepped-object list.
	All cubes share the rotation, so the frame costs one Quaternion and N dirty
	transforms, which is what this mode is here to measure."

	| rotation |
	animating ifFalse: [^ self].
	angle := angle + (deltaTime * 0.8).
	rotation := Quaternion new radiansAngle: angle axis: axis.
	self childrenDo: [:each |
		each isCube ifTrue: [each localRotation: rotation]].
]
