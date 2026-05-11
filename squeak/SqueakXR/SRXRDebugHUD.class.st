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
	#category : #rendering,
	#'squeak_changestamp' : 'MCPServer 4/30/2026 11:23'
}
SRXRDebugHUD >> draw2DDebugOn: aSRRenderer [
	"Draw the debug HUD as a 2D overlay"

	| white pos target dir raylibFPS |
	
	visible ifFalse: [^ self].
	
	white := RlColor new r: 255; g: 255; b: 255; a: 255.
	pos := aSRRenderer cameraPosition.
	target := aSRRenderer cameraTarget.
	dir := RlVector3 new 
		x: target x - pos x;
		y: target y - pos y;
		z: target z - pos z.
	raylibFPS := Raylib getFPS.
	
	Raylib 
		drawText: 'Debug HUD (F2 to toggle)' posX: 10 posY: 10 fontSize: 20 color: white.
	Raylib 
		drawText: 'FPS (Raylib): ', raylibFPS printString 
		posX: 10 posY: 35 fontSize: 16 color: white.
	Raylib 
		drawText: 'FPS (Measured): ', measuredFPS printString 
		posX: 10 posY: 55 fontSize: 16 color: white.
	Raylib 
		drawText: 'Position: ', (pos x roundTo: 0.01) printString, ', ', (pos y roundTo: 0.01) printString, ', ', (pos z roundTo: 0.01) printString 
		posX: 10 posY: 75 fontSize: 16 color: white.
	Raylib 
		drawText: 'Direction: ', (dir x roundTo: 0.01) printString, ', ', (dir y roundTo: 0.01) printString, ', ', (dir z roundTo: 0.01) printString 
		posX: 10 posY: 95 fontSize: 16 color: white.
]

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
	#'squeak_changestamp' : 'MCPServer 4/30/2026 11:23'
}
SRXRDebugHUD >> step: delta [
	"Calculate FPS based on actual step delta timing."
	
	| currentTime deltaMs |
	currentTime := Time millisecondClockValue.
	deltaMs := currentTime - lastStepTime.
	
	"Avoid division by zero and handle timer wrap-around"
	deltaMs > 0 ifTrue: [
		measuredFPS := (1000.0 / deltaMs) rounded].
	
	lastStepTime := currentTime.
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
