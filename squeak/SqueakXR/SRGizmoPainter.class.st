Class {
	#name : #SRGizmoPainter,
	#superclass : #SRObject,
	#instVars : [
		'commands',
		'commands2D'
	],
	#category : #'SqueakXR-Core'
}

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 5/11/2026 18:02'
}
SRGizmoPainter >> commands2D [

	^ commands2D
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 11/11/2025 14:33'
}
SRGizmoPainter >> drawSphere: command renderer: aSRRenderer [

	| transform |
	transform := (Matrix4x4 withOffset: command second) * (Matrix4x4 withScale: command third asVector3).
	aSRRenderer renderSphereTransformed: transform withColor: command fourth.
	"aSRRenderer
		drawSphereWiresCenterPos: command second
		radius: command third
		rings: 16
		slices: 16
		color: command fourth"
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'MCPServer 5/13/2026 13:59'
}
SRGizmoPainter >> drawText2D: command renderer: aSRRenderer [

	| text pos fontSize color |
	text := command second.
	pos := command third.
	fontSize := command fourth.
	color := command fifth.
	Raylib
		drawText: text
		posX: pos x
		posY: pos y
		fontSize: fontSize
		color: color asRlColor
]

{
	#category : #'3D gizmos',
	#'squeak_changestamp' : 'MCPServer 5/19/2026 16:41'
}
SRGizmoPainter >> drawWireBox: command renderer: aSRRenderer [
	"Slightly expand the wireframe so it pokes through any solid surface."
	| box color transform |
	box := command second.
	color := command third.
	transform := (Matrix4x4 withOffset: box center) * box rotation asMatrix4x4.
	Raylib rlPushMatrix;
		rlMultMatrixfMatf: transform transposed.
	Raylib
		drawCubeWiresPosition: (0 @ 0 @ 0) asRlVector
		width: box halfExtents x * 2.02
		height: box halfExtents y * 2.02
		length: box halfExtents z * 2.02
		color: color asRlColor.
	Raylib rlPopMatrix.
]

{
	#category : #'3D gizmos',
	#'squeak_changestamp' : 'MCPServer 5/19/2026 16:38'
}
SRGizmoPainter >> drawWirePlane: command renderer: aSRRenderer [
	"Draw a plane as a rectangle outline plus a small normal stick.
	Bounded planes use their width/height; unbounded planes use a default size."
	| plane color point normal up side halfW halfH rlColor c1 c2 c3 c4 |
	plane := command second.
	color := command third.
	point := plane point.
	normal := plane normal normalize.
	plane isBounded
		ifTrue: [
			up := plane up normalize.
			side := plane side normalize.
			halfW := plane width / 2.
			halfH := plane height / 2]
		ifFalse: [
			"Pick an arbitrary up perpendicular to normal."
			up := (normal closeTo: Vector3 up)
				ifTrue: [Vector3 forward]
				ifFalse: [Vector3 up].
			side := (normal cross: up) normalize.
			up := (side cross: normal) normalize.
			halfW := 1.0.
			halfH := 1.0].
	c1 := point + (side * halfW) + (up * halfH).
	c2 := point + (side * halfW) - (up * halfH).
	c3 := point - (side * halfW) - (up * halfH).
	c4 := point - (side * halfW) + (up * halfH).
	rlColor := color asRlColor.
	Raylib drawLine3DStartPos: c1 asRlVector endPos: c2 asRlVector color: rlColor.
	Raylib drawLine3DStartPos: c2 asRlVector endPos: c3 asRlVector color: rlColor.
	Raylib drawLine3DStartPos: c3 asRlVector endPos: c4 asRlVector color: rlColor.
	Raylib drawLine3DStartPos: c4 asRlVector endPos: c1 asRlVector color: rlColor.
	Raylib drawLine3DStartPos: point asRlVector endPos: (point + (normal * 0.3)) asRlVector color: rlColor.
]

{
	#category : #'2D gizmos',
	#'squeak_changestamp' : 'MCPServer 5/11/2026 17:57'
}
SRGizmoPainter >> gizmo2DText: aString at: aPoint fontSize: anInteger color: aColor [

	commands2D add: {#text2D. aString. aPoint. anInteger. aColor}
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 11/11/2025 14:24'
}
SRGizmoPainter >> gizmoSphere: globalPosition size: size color: color [

	commands add: {#sphere. globalPosition. size. color}
]

{
	#category : #'3D gizmos',
	#'squeak_changestamp' : 'SqueakXR 6/25/2026 16:14'
}
SRGizmoPainter >> gizmoWireBox: aSRCollisionBox color: aColor [

	commands add: {#wireBox. aSRCollisionBox. aColor}.
]

{
	#category : #'3D gizmos',
	#'squeak_changestamp' : 'SqueakXR 6/25/2026 16:15'
}
SRGizmoPainter >> gizmoWirePlane: aSRCollisionPlane color: aColor [

	commands add: {#wirePlane. aSRCollisionPlane. aColor}.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MCPServer 5/11/2026 17:57'
}
SRGizmoPainter >> initialize [

	super initialize.
	commands := OrderedCollection new.
	commands2D := OrderedCollection new
]

{
	#category : #testing,
	#'squeak_changestamp' : 'SqueakXR 6/25/2026 16:15'
}
SRGizmoPainter >> isGizmoPainter [

	^ true.
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'MCPServer 5/11/2026 17:57'
}
SRGizmoPainter >> render2DOn: aSRRenderer [

	commands2D do: [:command |
		command first caseOf: {
			[#text2D] -> [self drawText2D: command renderer: aSRRenderer]}].
	commands2D removeAll
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'MCPServer 5/19/2026 16:38'
}
SRGizmoPainter >> renderOn: aSRRenderer [

	commands do: [:command |
		command first caseOf: {
			[#sphere] -> [self drawSphere: command renderer: aSRRenderer].
			[#wireBox] -> [self drawWireBox: command renderer: aSRRenderer].
			[#wirePlane] -> [self drawWirePlane: command renderer: aSRRenderer]}].
	commands removeAll.
]
