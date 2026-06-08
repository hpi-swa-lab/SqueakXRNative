"
Debug HUD overlay. Toggle with F2.
"
Class {
	#name : #SRXRDebugHUD,
	#superclass : #SRObject,
	#instVars : [
		'visible',
		'lastStepTime',
		'measuredFPS'
	],
	#category : #'SqueakXR-Objects',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #initialization,
	#'squeak_changestamp' : 'MCPServer 5/13/2026 13:58'
}
SRXRDebugHUD >> initialize [

	super initialize.
	visible := false.
	lastStepTime := Time millisecondClockValue.
	measuredFPS := 0.
	isStepping := true
]

{
	#category : #testing,
	#'squeak_changestamp' : 'MCPServer 6/8/2026 15:47'
}
SRXRDebugHUD >> isDebugHUD [
	^ true.
]

{
	#category : #stepping,
	#'squeak_changestamp' : 'MCPServer 6/8/2026 15:47'
}
SRXRDebugHUD >> step: delta [
	"Calculate FPS and draw debug info using gizmos"
	
	| currentTime deltaMs white raylibFPS camera pos dir painter selText selected |
	currentTime := Time millisecondClockValue.
	deltaMs := currentTime - lastStepTime.
	
	deltaMs > 0 ifTrue: [
		measuredFPS := (1000.0 / deltaMs) rounded].
	
	lastStepTime := currentTime.
	
	visible ifFalse: [^ self].
	
	white := Color white.
	raylibFPS := Raylib getFPS.
	camera := self world renderer camera.
	pos := camera position asVector3.
	dir := (camera target asVector3 - pos) normalize.
	painter := self gizmoPainter.
	
	painter gizmo2DText: 'Debug HUD (F2 to toggle)' at: 10 @ 10 fontSize: 20 color: white.
	painter gizmo2DText: 'FPS (Raylib): ', raylibFPS printString at: 10 @ 35 fontSize: 16 color: white.
	painter gizmo2DText: 'FPS (Measured): ', measuredFPS printString at: 10 @ 55 fontSize: 16 color: white.
	painter gizmo2DText: 'Position: ', (pos x roundTo: 0.01) printString, ', ', (pos y roundTo: 0.01) printString, ', ', (pos z roundTo: 0.01) printString at: 10 @ 75 fontSize: 16 color: white.
	painter gizmo2DText: 'Direction: ', (dir x roundTo: 0.01) printString, ', ', (dir y roundTo: 0.01) printString, ', ', (dir z roundTo: 0.01) printString at: 10 @ 95 fontSize: 16 color: white.
	
	selected := self world avatar rightHand selectedObject.
	selText := selected
		ifNotNil: [:obj | obj class name, ' (', (obj name ifNil: ['unnamed']), ')']
		ifNil: ['none'].
	painter gizmo2DText: 'Selected: ', selText at: 10 @ 115 fontSize: 16 color: Color green.
	
	self world allDo: [:obj |
		| geom color |
		geom := obj collisionGeometry.
		color := obj == selected ifTrue: [Color green] ifFalse: [Color gray].
		geom isCollisionBox ifTrue: [
			painter gizmoWireBox: geom color: color].
		geom isCollisionPlane ifTrue: [
			painter gizmoWirePlane: geom color: color]].
]

{
	#category : #actions,
	#'squeak_changestamp' : 'MCPServer 5/13/2026 13:58'
}
SRXRDebugHUD >> toggleVisibility [

	visible := visible not
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 5/13/2026 13:58'
}
SRXRDebugHUD >> visible [

	^ visible
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 5/13/2026 13:58'
}
SRXRDebugHUD >> visible: aBoolean [

	visible := aBoolean
]
