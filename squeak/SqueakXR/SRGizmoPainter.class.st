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
	#'squeak_changestamp' : 'MCPServer 5/11/2026 17:57'
}
SRGizmoPainter >> drawText2D: command renderer: aSRRenderer [
	"Draw 2D text: {#text2D. aString. aPoint. fontSize. aColor}"
	
	| text pos fontSize color rlColor |
	text := command second.
	pos := command third.
	fontSize := command fourth.
	color := command fifth.
	rlColor := color asRlColor.
	
	Raylib
		drawText: text
		posX: pos x
		posY: pos y
		fontSize: fontSize
		color: rlColor
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
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MCPServer 5/11/2026 17:57'
}
SRGizmoPainter >> initialize [

	super initialize.
	commands := OrderedCollection new.
	commands2D := OrderedCollection new
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
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 11/11/2025 13:58'
}
SRGizmoPainter >> renderOn: aSRRenderer [

	commands do: [:command |
		command first caseOf: {
			[#sphere] -> [self drawSphere: command renderer: aSRRenderer]}].
	commands removeAll.
]
