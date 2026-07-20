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
	#'squeak_changestamp' : 'lege 7/20/2026 18:38'
}
SRXRDebugHUD >> initialize [

	super initialize.
	visible := false.
	lastStepTime := Time millisecondClockValue.
	measuredFPS := 0.
]

{
	#category : #testing,
	#'squeak_changestamp' : 'lege 7/20/2026 18:39'
}
SRXRDebugHUD >> isDebugHUD [

	^ true
]

{
	#category : #stepping,
	#'squeak_changestamp' : 'lege 7/20/2026 18:41'
}
SRXRDebugHUD >> step: delta [

	| currentTime deltaMs raylibFPS camera pos dir painter selText selected |
	currentTime := Time millisecondClockValue.
	deltaMs := currentTime - lastStepTime.
	
	deltaMs > 0 ifTrue: [
		measuredFPS := (1000.0 / deltaMs) rounded].
	
	lastStepTime := currentTime.
	
	visible ifFalse: [^ self].
	
	raylibFPS := Raylib getFPS.
	camera := self world renderer camera.
	pos := camera position asVector3.
	dir := (camera target asVector3 - pos) normalize.
	painter := self gizmoPainter.
	
	painter
		gizmo2DText: 'Debug HUD (F2 to toggle)' at: 10 @ 10 fontSize: 20 color: Color white;
		gizmo2DText: 'FPS (Raylib): ', raylibFPS printString at: 10 @ 35 fontSize: 16 color: Color white;
		gizmo2DText: 'FPS (Measured): ', measuredFPS printString at: 10 @ 55 fontSize: 16 color: Color white;
		gizmo2DText: 'Position: ', (pos x roundTo: 0.01) printString, ', ', (pos y roundTo: 0.01) printString, ', ', (pos z roundTo: 0.01) printString at: 10 @ 75 fontSize: 16 color: Color white;
		gizmo2DText: 'Direction: ', (dir x roundTo: 0.01) printString, ', ', (dir y roundTo: 0.01) printString, ', ', (dir z roundTo: 0.01) printString at: 10 @ 95 fontSize: 16 color: Color white.
	
	selected := self world avatar rightHand selectedObject.
	selText := selected
		ifNotNil: [:obj | obj class name, ' (', (obj name ifNil: ['unnamed']), ')']
		ifNil: ['none'].
	painter gizmo2DText: 'Selected: ', selText at: 10 @ 115 fontSize: 16 color: Color green.
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
