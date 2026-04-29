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
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MCPServer 4/29/2026 14:53'
}
SRXRDebugHUD >> draw [
	"Draw debug information on screen."
	
	| camera pos y lineHeight |
	visible ifFalse: [^ self].
	emulator ifNil: [^ self].
	camera := emulator emulatedCamera.
	camera ifNil: [^ self].
	
	y := 10.
	lineHeight := 20.
	
	"Camera position"
	pos := camera position.
	self drawText: 'Camera: ', pos x printShowingDecimalPlaces: 2, ' / ', 
		pos y printShowingDecimalPlaces: 2, ' / ', 
		pos z printShowingDecimalPlaces: 2 at: 10 @ y.
	y := y + lineHeight.
	
	"Look mode"
	self drawText: 'Look mode: ', (camera lookModeEnabled ifTrue: ['ON (mouse rotates camera)'] ifFalse: ['OFF (mouse controls hand)']) at: 10 @ y.
	y := y + lineHeight.
	
	"Controls hint"
	self drawText: 'TAB=toggle look | WASD=move | L-click=trigger | R-click=grab | F=raycast' at: 10 @ y
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MCPServer 4/29/2026 13:41'
}
SRXRDebugHUD >> drawText: aString at: aPoint [
	"Draw text at position using Raylib."
	
	Raylib
		drawTextText: aString
		posX: aPoint x
		posY: aPoint y
		fontSize: 16
		color: RlColors rayWhite
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
	#category : #rendering,
	#'squeak_changestamp' : 'MCPServer 4/29/2026 14:57'
}
SRXRDebugHUD >> renderOn: aSRRenderer [
	"Render the debug HUD. Draw 2D text during 3D rendering."
	
	self draw
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
