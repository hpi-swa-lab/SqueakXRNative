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
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 15:15'
}
SRRaylibRendererFlat >> beginViewFrom: aCameraTransform [

	self
		clearLitShaders;
		updateCamera: aCameraTransform.
	Raylib
		clearBackgroundColor: clearColor;
		beginMode3DCamera: camera.
	^ true
]

{
	#category : #'render-loop',
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 15:15'
}
SRRaylibRendererFlat >> drawWindowOverlay: aGizmoPainter [

	self drawReticle.
	aGizmoPainter render2DOn: self.
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
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 18:57'
}
SRRaylibRendererFlat >> setup [

	SRRenderer assertContext.
	SRDesktopInputState reset.
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
	#category : #window,
	#'squeak_changestamp' : 'MCPServer (jl) 11/16/2026 11:18'
}
SRRaylibRendererFlat >> toggleFullscreen [
	"Borderless, see #enterFullscreen: raylib toggles it both ways and restores the old window size."

	Raylib toggleBorderlessWindowed.
	fullscreen := self isFullscreen not.
]

{
	#category : #window,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 19:01'
}
SRRaylibRendererFlat >> windowExtent [

	^ self windowWidth @ self windowHeight
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 4/29/2026 18:36'
}
SRRaylibRendererFlat >> windowHeight [

	^ self class windowHeight
]

{
	#category : #window,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 15:15'
}
SRRaylibRendererFlat >> windowPriority [

	^ 2
]

{
	#category : #window,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 19:01'
}
SRRaylibRendererFlat >> windowTitle [

	^ 'Squeak 3D World'
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 4/29/2026 18:36'
}
SRRaylibRendererFlat >> windowWidth [

	^ self class windowWidth
]
