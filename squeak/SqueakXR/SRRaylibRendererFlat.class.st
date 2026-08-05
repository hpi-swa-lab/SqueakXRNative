Class {
	#name : #SRRaylibRendererFlat,
	#superclass : #SRRaylibRenderer,
	#instVars : [
		'reticleLines',
		'reticleColor'
	],
	#classVars : [
		'HighDpiEnabled',
		'WindowHeight',
		'WindowWidth'
	],
	#category : #'SqueakXR-Graphics-Renderer'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 4/1/2026 17:02'
}
SRRaylibRendererFlat class >> highDpiEnabled [
	<preference: 'High DPI Enabled in Flat'
		category: 'SqueakXR'
		description: 'Whether to enable high DPI rendering in a flat (non-XR) environment. Enable this if only part of the rendered image is shown in the window. Recommended for MacBook Retina displays.'
		type: #Boolean>
	^ HighDpiEnabled ifNil: [HighDpiEnabled := false]
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 4/1/2026 16:57'
}
SRRaylibRendererFlat class >> highDpiEnabled: aBoolean [

	HighDpiEnabled := aBoolean
]

{
	#category : #preferences,
	#'squeak_changestamp' : 'lege 7/16/2026 17:45'
}
SRRaylibRendererFlat class >> windowHeight [
	<preference: 'Height of the Raylib renderer window'
		category: 'SqueakXR'
		description: 'Height of the Raylib renderer window in pixels. Requires restart of renderer to take effect.'
		type: #Number>
	^ WindowHeight ifNil: [720]
]

{
	#category : #preferences,
	#'squeak_changestamp' : 'MCPServer 4/29/2026 18:36'
}
SRRaylibRendererFlat class >> windowHeight: aNumber [
	WindowHeight := aNumber
]

{
	#category : #preferences,
	#'squeak_changestamp' : 'lege 7/16/2026 17:44'
}
SRRaylibRendererFlat class >> windowWidth [
	<preference: 'Width of the Raylib renderer window'
		category: 'SqueakXR'
		description: 'Width of the Raylib renderer window in pixels. Requires restart of renderer to take effect.'
		type: #Number>
	^ WindowWidth ifNil: [1280]
]

{
	#category : #preferences,
	#'squeak_changestamp' : 'MCPServer 4/29/2026 18:36'
}
SRRaylibRendererFlat class >> windowWidth: aNumber [
	WindowWidth := aNumber
]

{
	#category : #'render-loop',
	#'squeak_changestamp' : 'lege 7/16/2026 17:47'
}
SRRaylibRendererFlat >> completeFrame [

	Raylib endMode3D.
	self drawReticle.
	
	SRWorld current gizmoPainter ifNotNil: [:painter | painter render2DOn: self].
	
	Raylib endDrawing.
	
	1 milliSecond wait.
]

{
	#category : #'render-loop',
	#'squeak_changestamp' : 'lege 3/25/2026 15:48'
}
SRRaylibRendererFlat >> drawReticle [

	reticleLines do: [:line |
		Raylib drawLineStartPosX: line first x
			startPosY: line first y
			endPosX: line second x
			endPosY: line second y
			color: reticleColor].
]

{
	#category : #initializing,
	#'squeak_changestamp' : 'lege 3/25/2026 15:45'
}
SRRaylibRendererFlat >> initReticle [

	| horiLineStart vertLineStart |
	horiLineStart := ((self windowWidth - self reticleSize) @ (self windowHeight)) / 2.
	vertLineStart := ((self windowWidth) @ (self windowHeight - self reticleSize)) / 2.
	reticleLines := {
		{horiLineStart. horiLineStart + (self reticleSize @ 0)}.
		{vertLineStart. vertLineStart + (0 @ self reticleSize)}.
	}.
	reticleColor := Color red asRaylibObject.
]

{
	#category : #initializing,
	#'squeak_changestamp' : 'lege 7/16/2026 17:49'
}
SRRaylibRendererFlat >> initialize [

	super initialize.
	
	self initReticle.
]

{
	#category : #'render-loop',
	#'squeak_changestamp' : 'MCPServer 5/13/2026 13:59'
}
SRRaylibRendererFlat >> prepareFrame: cameraTransform [

	| position forward up target |
	position := cameraTransform translation.
	forward := cameraTransform localDirToGlobal: Vector3 forward.
	up := cameraTransform localDirToGlobal: Vector3 up.
	target := position + forward.
	camera
		position: position asRlVector;
		target: target asRlVector;
		up: up asRlVector.
	Raylib
		beginDrawing;
		clearBackgroundColor: clearColor;
		beginMode3DCamera: camera;
		drawGridSlices: 10 spacing: 1.
	^ true
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 3/25/2026 15:48'
}
SRRaylibRendererFlat >> reticleSize [

	^ 50
]

{
	#category : #'render-loop',
	#'squeak_changestamp' : 'jl 4/27/2026 14:41'
}
SRRaylibRendererFlat >> setup [

	self class highDpiEnabled ifTrue: [
		Raylib setConfigFlags: RlConfigFlags flagWindowHighdpi].
	
	Raylib initWindowWidth: self windowWidth height: self windowHeight title: 'Squeak 3D World';
		setWindowMonitor: (Raylib getMonitorCount < self class startMonitor
			ifTrue: [0]
			ifFalse: [self class startMonitor]).
	
	camera := RlCamera3D new
		position: 10 asVector3 asRlVector;
		target: Vector3 zero asRlVector;
		up: Vector3 up asRlVector;
		fovy: 45;
		projection: RlCameraProjection cameraPerspective.
	
	Raylib
		"disableCursor;"
		setTargetFPS: -1.
]

{
	#category : #info,
	#'squeak_changestamp' : 'lege 3/11/2026 15:02'
}
SRRaylibRendererFlat >> shaderVersion [

	^ #'330'
]

{ #category : #'render-loop' }
SRRaylibRendererFlat >> shutdown [

	Raylib closeWindow.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 4/29/2026 18:36'
}
SRRaylibRendererFlat >> windowHeight [

	^ self class windowHeight
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 4/29/2026 18:36'
}
SRRaylibRendererFlat >> windowWidth [

	^ self class windowWidth
]
