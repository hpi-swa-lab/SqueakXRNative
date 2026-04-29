"
Debug HUD for displaying XR input emulation information on screen.
"
Class {
	#name : #SRXRDebugHUD,
	#superclass : #SRObject,
	#instVars : [
		'emulator',
		'visible'
	],
	#category : #'SqueakXR-Objects',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #rendering,
	#'squeak_changestamp' : 'MCPServer 4/29/2026 19:26'
}
SRXRDebugHUD >> draw2DDebugOn: aSRRenderer [
	"Draw the debug HUD as a 2D overlay"

	| white pos target dir |
	white := RlColor new r: 255; g: 255; b: 255; a: 255.
	pos := aSRRenderer cameraPosition.
	target := aSRRenderer cameraTarget.
	dir := RlVector3 new 
		x: target x - pos x;
		y: target y - pos y;
		z: target z - pos z.
	
	Raylib 
		drawText: 'Camera Debug:' posX: 10 posY: 10 fontSize: 20 color: white.
	Raylib 
		drawText: 'Position: ', (pos x roundTo: 0.01) printString, ', ', (pos y roundTo: 0.01) printString, ', ', (pos z roundTo: 0.01) printString 
		posX: 10 posY: 35 fontSize: 16 color: white.
	Raylib 
		drawText: 'Direction: ', (dir x roundTo: 0.01) printString, ', ', (dir y roundTo: 0.01) printString, ', ', (dir z roundTo: 0.01) printString 
		posX: 10 posY: 55 fontSize: 16 color: white.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'jl 4/29/2026 19:13'
}
SRXRDebugHUD >> drawText: aString at: aPoint [
	"Draw text at position using Raylib."
	
	Raylib
		drawTextText: aString
		posX: aPoint x
		posY: aPoint y
		fontSize: 16
		color: (RlColor externalNew r: 255; g: 255; b: 255; a: 255).
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MCPServer 4/29/2026 13:41'
}
SRXRDebugHUD >> emulator: anEmulator [
	"Set the input emulator to display debug info for."
	
	emulator := anEmulator
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'MCPServer 4/29/2026 15:06'
}
SRXRDebugHUD >> initialize [
	"Initialize with HUD disabled by default."
	
	super initialize.
	visible := false
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
