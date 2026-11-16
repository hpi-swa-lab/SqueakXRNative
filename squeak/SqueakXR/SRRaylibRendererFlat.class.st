Class {
	#name : #SRRaylibRendererFlat,
	#superclass : #SRRaylibRenderer,
	#instVars : [
		'fullscreen'
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
	#'squeak_changestamp' : 'MCPServer 10/23/2026 10:12'
}
SRRaylibRendererFlat >> completeFrame [
	"The loop only reschedules here, and it has to sit after #endDrawing, which discards unread 
	input."
	Raylib endMode3D.
	self drawReticle.

	SRWorld current gizmoPainter ifNotNil: [:painter | painter render2DOn: self].

	Raylib endDrawing.

	1 milliSecond wait.

]

{
	#category : #'render-loop',
	#'squeak_changestamp' : 'MCPServer (jl) 11/16/2026 11:19'
}
SRRaylibRendererFlat >> drawReticle [
	"Centred on the screen as it is now, which a fullscreen toggle changes."

	| centre half color |
	centre := (Raylib getScreenWidth // 2) @ (Raylib getScreenHeight // 2).
	half := self reticleSize // 2.
	color := self class rlColorFor_1: Color red.
	Raylib
		drawLineStartPosX: centre x - half startPosY: centre y
			endPosX: centre x + half endPosY: centre y color: color;
		drawLineStartPosX: centre x startPosY: centre y - half
			endPosX: centre x endPosY: centre y + half color: color.
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'MCPServer (jl) 11/13/2026 16:02'
}
SRRaylibRendererFlat >> enterFullscreen [
	"Borderless, not exclusive: ToggleFullscreen grabs the monitor on Windows, Alt-Tab cannot get past it."
	Raylib toggleBorderlessWindowed.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer (jl) 11/13/2026 15:00'
}
SRRaylibRendererFlat >> fullscreen: aBoolean [

	fullscreen := aBoolean.
]

{
	#category : #window,
	#'squeak_changestamp' : 'MCPServer (jl) 11/16/2026 11:18'
}
SRRaylibRendererFlat >> isFullscreen [

	^ fullscreen == true
]

{
	#category : #'render-loop',
	#'squeak_changestamp' : 'leo 11/6/2026 15:55'
}
SRRaylibRendererFlat >> prepareFrame: cameraTransform [

	self
		clearLitShaders;
		updateCamera: cameraTransform.
	Raylib
		beginDrawing;
		clearBackgroundColor: clearColor;
		beginMode3DCamera: camera.
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
	#'squeak_changestamp' : 'MCPServer (jl) 11/13/2026 15:00'
}
SRRaylibRendererFlat >> setup [

	SRDesktopInputState reset.
	
	self class highDpiEnabled ifTrue: [
		Raylib setConfigFlags: RlConfigFlags flagWindowHighdpi].
	
	Raylib initWindowWidth: self windowWidth height: self windowHeight title: 'Squeak 3D World';
		setWindowMonitor: (Raylib getMonitorCount < self class startMonitor
			ifTrue: [0]
			ifFalse: [self class startMonitor]).
	fullscreen == true ifTrue: [self enterFullscreen].
	
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
	#category : #window,
	#'squeak_changestamp' : 'MCPServer (jl) 11/16/2026 11:18'
}
SRRaylibRendererFlat >> toggleFullscreen [
	"Borderless, see #enterFullscreen: raylib toggles it both ways and restores the old window size."

	Raylib toggleBorderlessWindowed.
	fullscreen := self isFullscreen not.
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
