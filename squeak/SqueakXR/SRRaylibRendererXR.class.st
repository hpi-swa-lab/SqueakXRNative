Class {
	#name : #SRRaylibRendererXR,
	#superclass : #SRRaylibRenderer,
	#category : #'SqueakXR-Core'
}

{
	#category : #'render-loop',
	#'squeak_changestamp' : 'lege 3/13/2026 15:54'
}
SRRaylibRendererXR >> completeFrame [

	Raylib
		endMode3D;
		endDrawing;
		rlOpenXRBlitToWindowEye: RlRLOpenXREyeEnum rlopenxrEyeBoth
			keep_aspect_ratio: true;
		rlOpenXREnd.
	
	1 milliSecond wait.
]

{
	#category : #'render-loop',
	#'squeak_changestamp' : 'lege 10/8/2025 15:52'
}
SRRaylibRendererXR >> prepareFrame: cameraTransform [

	| beginSuccessful |
	Raylib
		rlOpenXRUpdate;
		updateCamera: camera mode: RlCameraMode cameraFree;
		rlOpenXRUpdateCamera: camera;
		clearBackgroundColor: clearColor.
	
	camera position: (cameraTransform translation + (Vector3 fromRlVector3: camera position)) asRlVector.
	camera target: (cameraTransform translation + (Vector3 fromRlVector3: camera target)) asRlVector.
	"TODO camera rotation"
		
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

{ #category : #'render-loop' }
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
