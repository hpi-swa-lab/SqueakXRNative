Class {
	#name : #SRRaylibRendererFlat,
	#superclass : #SRRaylibRenderer,
	#instVars : [
		'reticleLines'
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
	#'squeak_changestamp' : 'MCPServer 10/13/2026 14:59'
}
SRRaylibRendererFlat >> completeFrame [

	Raylib endMode3D.
	self drawReticle.
	
	SRWorld current gizmoPainter ifNotNil: [:painter | painter render2DOn: self].
	
	Raylib endDrawing.
	
	"The loop's only rescheduling point, and it has to sit *after* endDrawing.
	
	It used to sit before it, on the idea that the GPU could work on this frame while
	Morphic runs. It cannot: endDrawing is what submits raylib's draw batch and swaps
	buffers, so before it nothing has been handed to the GPU at all and the wait
	overlapped Morphic with nothing.
	
	Worse, it cost us most of our input. endDrawing ends with PollInputEvents, which
	collapses press/release edges and empties the key queues. While we are suspended
	here the image goes idle and both the VM and Morphic pump the OS event queue -- the
	same queue raylib's GLFW window feeds from on Win32 and Cocoa -- so OS input landed
	in raylib's state and was then wiped by the poll that immediately followed, without
	anybody ever reading it. Measured on Windows: `1 milliSecond wait' really takes
	~15.3 ms (the 15.6 ms timer tick) out of a ~17 ms frame, i.e. nearly the whole
	frame was that window. See SRDesktopInputState."
	1 milliSecond wait.

]

{
	#category : #'render-loop',
	#'squeak_changestamp' : 'leo 9/29/2026 15:34'
}
SRRaylibRendererFlat >> drawReticle [

	reticleLines do: [:line |
		Raylib drawLineStartPosX: line first x
			startPosY: line first y
			endPosX: line second x
			endPosY: line second y
			color: (self class rlColorFor_1: Color red)].
]

{
	#category : #initializing,
	#'squeak_changestamp' : 'MCPServer 9/29/2026 15:33'
}
SRRaylibRendererFlat >> initReticle [

	| horiLineStart vertLineStart |
	horiLineStart := ((self windowWidth - self reticleSize) @ (self windowHeight)) / 2.
	vertLineStart := ((self windowWidth) @ (self windowHeight - self reticleSize)) / 2.
	reticleLines := {
		{horiLineStart. horiLineStart + (self reticleSize @ 0)}.
		{vertLineStart. vertLineStart + (0 @ self reticleSize)}.
	}.
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
	#'squeak_changestamp' : 'MCPServer 10/14/2026 09:52'
}
SRRaylibRendererFlat >> prepareFrame: cameraTransform [

	| position forward up target |
	position := cameraTransform translation.
	forward := cameraTransform localDirToGlobal: Vector3 forward.
	up := cameraTransform localDirToGlobal: Vector3 up.
	target := position + forward.
	camera
		position: (self class rlVector3For_1: position);
		target: (self class rlVector3For_2: target);
		up: (self class rlVector3For_3: up).
	Raylib
		beginDrawing;
		clearBackgroundColor: clearColor;
		beginMode3DCamera: camera.
	self drawGrid.
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
	#'squeak_changestamp' : 'MCPServer 10/13/2026 14:59'
}
SRRaylibRendererFlat >> setup [

	SRDesktopInputState reset.
	
	self class highDpiEnabled ifTrue: [
		Raylib setConfigFlags: RlConfigFlags flagWindowHighdpi].
	
	Raylib initWindowWidth: self windowWidth height: self windowHeight title: 'Squeak 3D World';
		setWindowMonitor: (Raylib getMonitorCount < self class startMonitor
			ifTrue: [0]
			ifFalse: [self class startMonitor]).
	
	camera := RlCamera3D new
		position: (self class rlVector3For_1: 10 asVector3);
		target: self class rlVectorZero;
		up: (self class rlVector3For_2: Vector3 up);
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
