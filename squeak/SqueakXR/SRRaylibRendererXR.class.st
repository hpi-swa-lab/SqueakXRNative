Class {
	#name : #SRRaylibRendererXR,
	#superclass : #SRRaylibRenderer,
	#category : #'SqueakXR-Core'
}

{ #category : #'render-loop' }
SRRaylibRendererXR >> completeFrame [

	Raylib
		endMode3D;
		endDrawing;
		rlOpenXRBlitToWindowEye: RlRLOpenXREyeEnum rlopenxrEyeBoth
			keep_aspect_ratio: true;
		rlOpenXREnd.
	
	1 milliSecond wait.
]

{ #category : #'render-loop' }
SRRaylibRendererXR >> prepareFrame [

	| beginSuccessful |
	Raylib
		rlOpenXRUpdate;
		updateCamera: camera mode: RlCameraMode cameraFree;
		rlOpenXRUpdateCamera: camera;
		clearBackgroundColor: clearColor.
		
	beginSuccessful := Raylib rlOpenXRBegin.
	
	beginSuccessful ifTrue: [
			Raylib
				clearBackgroundColor: clearColor;
				beginMode3DCamera: camera;
				drawGridSlices: 10 spacing: 1].
	
	^ beginSuccessful
		
]

{ #category : #'render-loop' }
SRRaylibRendererXR >> setup [
	
	Raylib
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

{ #category : #'render-loop' }
SRRaylibRendererXR >> shutdown [

	Raylib
		rlOpenXRShutdown;
		closeWindow.
]
