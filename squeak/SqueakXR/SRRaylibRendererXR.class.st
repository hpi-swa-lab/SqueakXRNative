Class {
	#name : #SRRaylibRendererXR,
	#superclass : #SRRaylibRenderer,
	#category : #'SqueakXR-Graphics-Renderer'
}

{
	#category : #'render-loop',
	#'squeak_changestamp' : 'leo 11/6/2026 15:57'
}
SRRaylibRendererXR >> completeFrame [

	[Raylib endMode3D.

	SRWorld current ifNotNil: [:each |
		each gizmoPainter ifNotNil: [:painter | painter render2DOn: self]].

	self withMirrorFramebufferExtentDo: [
		Raylib
			rlOpenXRBlitToWindowEye: RlRLOpenXREyeEnum rlopenxrEyeLeft
				keep_aspect_ratio: true]]
		ensure: [
			Raylib
				rlOpenXREnd;
				endDrawing].
	
	1 milliSecond wait.
	
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
	#'squeak_changestamp' : 'leo 11/9/2026 15:34'
}
SRRaylibRendererXR >> prepareFrame: cameraTransform [

	| beginSuccessful |
	Raylib clearBackgroundColor: clearColor.
	self
		clearLitShaders;
		updateCamera: cameraTransform.
	beginSuccessful := Raylib rlOpenXRBegin.
	
	beginSuccessful ifTrue: [
			self placeMirrorWindowOnce.
			Raylib
				clearBackgroundColor: clearColor;
				beginMode3DCamera: camera].
	
	^ beginSuccessful
]

{
	#category : #'render-loop',
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 15:01'
}
SRRaylibRendererXR >> setup [
	"Returning early leaves the XrInstance null, and the frame loop then calls through null 
	function pointers and takes the VM down."
	Raylib

		initWindowWidth: 2468 height: 2130 title: 'SqueakXR';
		setTargetFPS: -1.

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
