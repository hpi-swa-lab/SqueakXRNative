Class {
	#name : #SRRaylibRendererFlat,
	#superclass : #SRRaylibRenderer,
	#instVars : [
		'reticleLines',
		'reticleColor'
	],
	#classVars : [
		'HighDpiEnabled'
	],
	#category : #'SqueakXR-Core'
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
	#category : #'render-loop',
	#'squeak_changestamp' : 'MCPServer 4/29/2026 14:56'
}
SRRaylibRendererFlat >> completeFrame [

	Raylib endMode3D.
	self drawReticle.
	Raylib endDrawing.
	
	1 milliSecond wait
]

{
	#category : #'render-loop',
	#'squeak_changestamp' : 'MCPServer 4/29/2026 14:53'
}
SRRaylibRendererFlat >> completeFrame: aWorld [
	"Complete the frame, drawing 2D overlays after 3D rendering."
	
	| inputEmulator debugHUD |
	Raylib endMode3D.
	self drawReticle.
	
	"Find and render debug HUD if present"
	inputEmulator := aWorld allDescendants 
		detect: [:obj | obj isKindOf: SRXRInputEmulator] 
		ifNone: [nil].
	inputEmulator ifNotNil: [
		debugHUD := inputEmulator debugHUD.
		debugHUD ifNotNil: [debugHUD draw]].
	
	Raylib endDrawing.
	
	1 milliSecond wait
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
	#'squeak_changestamp' : 'MCPServer 4/28/2026 19:09'
}
SRRaylibRendererFlat >> initialize [

	super initialize.
	self initReticle
]

{
	#category : #'render-loop',
	#'squeak_changestamp' : 'MCPServer 4/28/2026 19:09'
}
SRRaylibRendererFlat >> prepareFrame: cameraTransform [
	"Prepare for rendering a frame. Camera is controlled by SRXREmulatedCamera, not Raylib."
	
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
	#'squeak_changestamp' : 'jl 4/22/2026 15:12'
}
SRRaylibRendererFlat >> windowHeight [

	^ 1400
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'jl 4/22/2026 15:12'
}
SRRaylibRendererFlat >> windowWidth [

	^ 2400
]
