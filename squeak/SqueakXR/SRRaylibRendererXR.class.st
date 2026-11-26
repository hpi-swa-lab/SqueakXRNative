Class {
	#name : #SRRaylibRendererXR,
	#superclass : #SRRaylibRenderer,
	#category : #'SqueakXR-Graphics-Renderer'
}

{
	#category : #'render-loop',
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 15:15'
}
SRRaylibRendererXR >> beginViewFrom: aCameraTransform [

	| beginSuccessful |
	Raylib clearBackgroundColor: clearColor.
	self
		clearLitShaders;
		updateCamera: aCameraTransform.
	beginSuccessful := Raylib rlOpenXRBegin.
	beginSuccessful ifTrue: [
		Raylib
			clearBackgroundColor: clearColor;
			beginMode3DCamera: camera].
	^ beginSuccessful
]

{
	#category : #testing,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 17:05'
}
SRRaylibRendererXR >> canStartWhileRunning [
	"OpenXR input is only set up when the world starts."

	^ false
]

{
	#category : #'render-loop',
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 15:15'
}
SRRaylibRendererXR >> drawWindowOverlay: aGizmoPainter [
	"Without another view in the window, it mirrors the left eye."

	aGizmoPainter render2DOn: self.
	self placeMirrorWindowOnce.
	self withMirrorFramebufferExtentDo: [
		Raylib
			rlOpenXRBlitToWindowEye: RlRLOpenXREyeEnum rlopenxrEyeLeft
				keep_aspect_ratio: true]
]

{
	#category : #'render-loop',
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 15:15'
}
SRRaylibRendererXR >> endView [

	Raylib rlOpenXREnd.
]

{
	#category : #testing,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 15:15'
}
SRRaylibRendererXR >> isXR [

	^ true
]

{
	#category : #window,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 15:00'
}
SRRaylibRendererXR >> mirrorAspect [

	^ Raylib rlGetFramebufferWidth / 2.0 / Raylib rlGetFramebufferHeight
]

{
	#category : #'render-loop',
	#'squeak_changestamp' : 'MCPServer (leo) 10/19/2026 16:07'
}
SRRaylibRendererXR >> pollEventsAndWaitForFrame [

	Raylib rlOpenXRUpdate.
]

{
	#category : #'render-loop',
	#'squeak_changestamp' : 'leo 11/25/2026 19:28'
}
SRRaylibRendererXR >> setup [
	"Returning early leaves the XrInstance null, and the frame loop then calls through null 
	function pointers and takes the VM down."
	SRRenderer assertContext.
	Raylib setTargetFPS: -1.

	Raylib rlOpenXRSetup
		ifTrue: [Transcript showln: 'rlOpenXRSetup succeeded']
		ifFalse: [

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
	#category : #'render-loop',
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 17:05'
}
SRRaylibRendererXR >> shutdown [

	Raylib rlOpenXRShutdown.
]

{
	#category : #window,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 19:01'
}
SRRaylibRendererXR >> windowExtent [

	^ 2468 @ 2130
]

{
	#category : #window,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 15:15'
}
SRRaylibRendererXR >> windowPriority [

	^ 1
]

{
	#category : #window,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 19:01'
}
SRRaylibRendererXR >> windowTitle [

	^ 'SqueakXR'
]

{
	#category : #'render-loop',
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 15:01'
}
SRRaylibRendererXR >> withMirrorFramebufferExtentDo: aBlock [
	"rlOpenXRBlitToWindow reads its destination from rlGetFramebufferWidth/Height, which 
	rlOpenXR leaves at the swapchain extent."
	| xrExtent |
	xrExtent := Raylib rlGetFramebufferWidth @ Raylib rlGetFramebufferHeight.

	Raylib
		rlSetFramebufferWidth: Raylib getScreenWidth;
		rlSetFramebufferHeight: Raylib getScreenHeight.
	aBlock ensure: [
		Raylib
			rlSetFramebufferWidth: xrExtent x;
			rlSetFramebufferHeight: xrExtent y].

]
