Class {
	#name : #SRRaylibRendererXR,
	#superclass : #SRRaylibRenderer,
	#instVars : [
		'renderTarget'
	],
	#category : #'SqueakXR-Core'
}

{
	#category : #'render-loop',
	#'squeak_changestamp' : 'phkeese 8/25/2026 14:54'
}
SRRaylibRendererXR >> completeFrame [ 

	SRWorld current gizmoPainter ifNotNil: [:painter | painter render2DOn: self].
	
	Raylib
		endDrawing;
		rlOpenXRBlitToWindowEye: RlRLOpenXREyeEnum rlopenxrEyeBoth
			keep_aspect_ratio: true;
		rlOpenXREnd.
	
	1 milliSecond wait.
]

{
	#category : #'render-loop',
	#'squeak_changestamp' : 'phkeese 8/25/2026 14:54'
}
SRRaylibRendererXR >> completePass [

	Raylib
		endMode3D;
		endTextureMode;
		drawTextureRecTexture: renderTarget texture 
			source: (RlRectangle new
				width: 1200;
				height: 0 - 900)
			position: (0@0) asVector asRlVector
			tint: Color white asRlColor.
]

{
	#category : #'render-loop',
	#'squeak_changestamp' : 'phkeese 8/25/2026 14:52'
}
SRRaylibRendererXR >> prepareFrame: cameraTransform [

	| beginSuccessful forward position target up |
	Raylib
		rlOpenXRUpdate;
		clearBackgroundColor: clearColor.

	position := cameraTransform translation.
	forward := cameraTransform localDirToGlobal: Vector3 forward.
	up := cameraTransform localDirToGlobal: Vector3 up.
	target := position + forward.
	camera
		position: position asRlVector;
		target: target asRlVector;
		up: up asRlVector.
		
	beginSuccessful := Raylib rlOpenXRBegin.
	
	beginSuccessful ifTrue: [ Raylib clearBackgroundColor: clearColor ].
			
	^ beginSuccessful
]

{
	#category : #'render-loop',
	#'squeak_changestamp' : 'phkeese 8/25/2026 14:51'
}
SRRaylibRendererXR >> preparePass: aName [

	Raylib
		beginTextureModeTarget: renderTarget;
		clearBackgroundColor: Color transparent asRlColor;
		beginMode3DCamera: camera;
		drawGridSlices: 10 spacing: 1.
]

{
	#category : #'render-loop',
	#'squeak_changestamp' : 'phkeese 8/24/2026 15:47'
}
SRRaylibRendererXR >> preparePass: cameraTransform named: aName [

	| beginSuccessful forward position target up |
	Raylib
		rlOpenXRUpdate;
		clearBackgroundColor: clearColor.

	position := cameraTransform translation.
	forward := cameraTransform localDirToGlobal: Vector3 forward.
	up := cameraTransform localDirToGlobal: Vector3 up.
	target := position + forward.
	camera
		position: position asRlVector;
		target: target asRlVector;
		up: up asRlVector.
		
	beginSuccessful := Raylib rlOpenXRBegin.
	
	beginSuccessful ifTrue: [
			Raylib
				clearBackgroundColor: clearColor;
				beginMode3DCamera: camera;
				drawGridSlices: 10 spacing: 1].
	
	"Orthographic projection -- for posterity, do not use
	mat := ((Matrix4x4 ortho: (Rectangle exactCenter: 0 asPoint extent: 2 asPoint) near: 0.1 far: 100) scaledBy: 1 @ -1 @ 1) asRlMatrix.
	offset := (Matrix4x4 withOffset: 1 @ 0 @ 0) asRlMatrix.
	offset2 := (Matrix4x4 withOffset: -1 @ 0 @ 0) asRlMatrix.
	Raylib rlSetMatrixProjectionStereoRight: mat left: mat;
	rlSetMatrixViewOffsetStereoRight: offset left: offset2."
	
	^ beginSuccessful
		
]

{
	#category : #'render-loop',
	#'squeak_changestamp' : 'phkeese 8/25/2026 14:46'
}
SRRaylibRendererXR >> setup [
	
	Raylib
		"setConfigFlags: ({
				RlConfigFlags flagMsaa4xHint.
				RlConfigFlags flagWindowHighdpi}
			inject: 0 into: [:allFlags :flag | allFlags bitOr: flag]);"
		initWindowWidth: 1200 height: 900 title: 'SqueakXR';
		setTargetFPS: -1.
	
	Raylib rlOpenXRSetup
		ifTrue: [Transcript showln: 'rlOpenXRSetup succeeded']
		ifFalse: [
			Transcript showln: 'Failed to initialise rlOpenXR!'.
			^ self].
	
	renderTarget := Raylib
		loadRenderTextureWidth: 1200 height: 900.
	
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
