Class {
	#name : #SRRaylibRendererXR,
	#superclass : #SRRaylibRenderer,
	#category : #'SqueakXR-Graphics-Renderer'
}

{
	#category : #'render-loop',
	#'squeak_changestamp' : 'MCPServer (jl) 10/21/2026 13:16'
}
SRRaylibRendererXR >> completeFrame [

	"Everything up to #rlOpenXREnd is in the protected block: the overlay and the
	mirror blit are both optional, and skipping #rlOpenXREnd is not -- an
	unbalanced begin leaves the session open for every frame after it.
	SRWorld current is read through ifNotNil: because the registry is empty while
	a world is being swapped, and a decapitated completeFrame was how this was
	found."
	[Raylib endMode3D.

	SRWorld current ifNotNil: [:each |
		each gizmoPainter ifNotNil: [:painter | painter render2DOn: self]].

	"The blit needs rlOpenXR still drawing (it asserts on active_fbo), and endDrawing
	swaps the window, so a swap before the blit presents the buffer the blit has not
	written yet."
	self withMirrorFramebufferExtentDo: [
		Raylib
			rlOpenXRBlitToWindowEye: RlRLOpenXREyeEnum rlopenxrEyeLeft
				keep_aspect_ratio: true]]
		ensure: [
			Raylib
				rlOpenXREnd;
				endDrawing].
	
	"After the raylib tail, not before it: endDrawing ends with PollInputEvents, which
	destroys any input that arrived while we were suspended here. See
	SRRaylibRendererFlat>>completeFrame and SRDesktopInputState."
	1 milliSecond wait.
	
]

{
	#category : #window,
	#'squeak_changestamp' : 'MCPServer 10/14/2026 10:30'
}
SRRaylibRendererXR >> mirrorAspect [
	"rlgl's framebuffer extent spans both eyes, and the mirror shows one of them."

	^ Raylib rlGetFramebufferWidth / 2.0 / Raylib rlGetFramebufferHeight
]

{
	#category : #'render-loop',
	#'squeak_changestamp' : 'MCPServer 9/21/2026 15:28'
}
SRRaylibRendererXR >> pollEventsAndWaitForFrame [
	"Session state changes and xrWaitFrame. The wait latches predictedDisplayTime,
	which rlOpenXRGetTime then hands to everything locating a pose, so nothing may
	sample a pose before this."

	Raylib rlOpenXRUpdate.
]

{
	#category : #'render-loop',
	#'squeak_changestamp' : 'MCPServer 10/14/2026 10:36'
}
SRRaylibRendererXR >> prepareFrame: cameraTransform [

	| beginSuccessful forward position target up |
	Raylib clearBackgroundColor: clearColor.

	position := cameraTransform translation.
	forward := cameraTransform localDirToGlobal: Vector3 forward.
	up := cameraTransform localDirToGlobal: Vector3 up.
	target := position + forward.
	camera
		position: (self class rlVector3For_1: position);
		target: (self class rlVector3For_2: target);
		up: (self class rlVector3For_3: up).
		
	beginSuccessful := Raylib rlOpenXRBegin.
	
	beginSuccessful ifTrue: [
			self placeMirrorWindowOnce.
			Raylib
				clearBackgroundColor: clearColor;
				beginMode3DCamera: camera.
			self drawGrid].
	
	^ beginSuccessful
]

{
	#category : #'render-loop',
	#'squeak_changestamp' : 'MCPServer 10/14/2026 10:20'
}
SRRaylibRendererXR >> setup [
	
	Raylib
		"setConfigFlags: ({
				RlConfigFlags flagMsaa4xHint.
				RlConfigFlags flagWindowHighdpi}
			inject: 0 into: [:allFlags :flag | allFlags bitOr: flag]);"
		"The mirror blit in #completeFrame letterboxes against dest.offset {0,0} rather
		than centring, so the window is sized near one eye's extent to stay readable."
		initWindowWidth: 2468 height: 2130 title: 'SqueakXR';
		setTargetFPS: -1.
	
	Raylib rlOpenXRSetup
		ifTrue: [Transcript showln: 'rlOpenXRSetup succeeded']
		ifFalse: [
			"Returning leaves the XrInstance null, and the frame loop then calls
			through null function pointers and takes the VM down."
			Transcript showln: 'Failed to initialise rlOpenXR!'.
			^ self error: 'rlOpenXRSetup failed, see the console for the XrResult'].
	
	camera := RlCamera3D new
		position: (RlVector3 new x: 10; y: 10; z: 10);
		target: (RlVector3 new x: 0; y: 3; z: 0);
		up: (RlVector3 new x: 0; y: 1; z: 0);
		fovy: 45;
		projection: RlCameraProjection cameraPerspective.
]

{
	#category : #info,
	#'squeak_changestamp' : 'lege 3/11/2026 15:02'
}
SRRaylibRendererXR >> shaderVersion [

	^ #'300es'
]

{ #category : #'render-loop' }
SRRaylibRendererXR >> shutdown [

	Raylib
		rlOpenXRShutdown;
		closeWindow.
]

{
	#category : #'render-loop',
	#'squeak_changestamp' : 'MCPServer 10/14/2026 10:28'
}
SRRaylibRendererXR >> withMirrorFramebufferExtentDo: aBlock [
	"rlOpenXRBlitToWindow takes its destination rect from rlGetFramebufferWidth/Height,
	which rlOpenXR leaves at the swapchain extent, so the blit lands in a rect far larger
	than the window and only its lower left corner is visible. rlgl's extent also drives
	the per-eye viewport split, so it has to go back before the next frame draws."

	| xrExtent |
	xrExtent := Raylib rlGetFramebufferWidth @ Raylib rlGetFramebufferHeight.
	"getRenderWidth reports the swapchain extent here, not the window; getScreenWidth
	still tracks setWindowSize."
	Raylib
		rlSetFramebufferWidth: Raylib getScreenWidth;
		rlSetFramebufferHeight: Raylib getScreenHeight.
	aBlock ensure: [
		Raylib
			rlSetFramebufferWidth: xrExtent x;
			rlSetFramebufferHeight: xrExtent y].
]
