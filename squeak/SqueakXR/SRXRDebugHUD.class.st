"
Debug HUD for displaying XR input emulation information on screen.
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
	#'squeak_changestamp' : 'MCPServer 4/30/2026 11:24'
}
SRXRDebugHUD >> initialize [
	"Initialize with HUD disabled by default."
	
	super initialize.
	visible := false.
	lastStepTime := Time millisecondClockValue.
	measuredFPS := 0.
	isStepping := true.
]

{
	#category : #stepping,
	#'squeak_changestamp' : 'MCPServer 5/11/2026 18:03'
}
SRXRDebugHUD >> step: delta [
	"Calculate FPS and draw debug info using gizmos"
	
	| currentTime deltaMs white raylibFPS camera pos dir painter |
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
	painter gizmo2DText: 'Direction: ', (dir x roundTo: 0.01) printString, ', ', (dir y roundTo: 0.01) printString, ', ', (dir z roundTo: 0.01) printString at: 10 @ 95 fontSize: 16 color: white
]

{
	#category : #actions,
	#'squeak_changestamp' : 'MCPServer 4/29/2026 14:53'
}
SRXRDebugHUD >> toggleVisibility [
	"Toggle HUD visibility."
	
	visible := visible not
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 4/29/2026 14:53'
}
SRXRDebugHUD >> visible [
	"Return whether the HUD is visible."
	
	^ visible
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 4/29/2026 14:53'
}
SRXRDebugHUD >> visible: aBoolean [
	"Set whether the HUD is visible."
	
	visible := aBoolean
]
