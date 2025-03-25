Class {
	#name : #SXRenderer,
	#superclass : #Object,
	#category : #'SqueakXR-Core'
}

{ #category : #'as yet unclassified' }
SXRenderer >> simpleDrawLoop [

	"adapt https://github.com/FireFlyForLife/rlOpenXR/blob/main/examples/1_hello_vr.c"
	
	| cam blue red white |
	Raylib initWindowWidth: 1200 height: 900 title: 'SqueakXR'.
	
	cam := RlCamera3D externalNew
		position: (RlVector3 new x: 10; y: 10; z: 10);
		target: (RlVector3 new x: 0; y: 3; z: 0);
		up: (RlVector3 new x: 0; y: 1; z: 0);
		fovy: 45;
		projection: RlCameraProjection cameraPerspective.
	white := RlColor externalNew r: 255; g: 255; b: 255; a: 255.
	blue := RlColor externalNew r: 100; g: 100; b: 255; a: 255.
	red := RlColor externalNew r: 255; g: 0; b: 0; a: 128.
	
	[
	Raylib
		"setCameraModeCamera: RlCameraMode cameraFree;"
		setTargetFPS: -1.
	
	Raylib rlOpenXRSetup
		ifTrue: [Transcript showln: 'rlOpenXRSetup succeeded']
		ifFalse: [
			Transcript showln: 'Failed to initialise rlOpenXR!'.
			^ self].
	
	[Raylib windowShouldClose] whileFalse: [
		"Update"
		Raylib
			rlOpenXRUpdate;
			updateCamera: cam mode: RlCameraMode cameraFree;
			rlOpenXRUpdateCamera: cam.
		
		"Draw"
		Raylib clearBackgroundColor: white.
		Raylib rlOpenXRBegin ifTrue: [
			Raylib
				clearBackgroundColor: blue;
				beginMode3DCamera: cam;
				drawCubePosition: (RlVector3 new x: 3; y: 0; z: 0)
					width: 2
					height: 2
					length: 2
					color: red;
				drawGridSlices: 10 spacing: 1;
				endMode3D;
				rlOpenXRBlitToWindowEye: RlRLOpenXREyeEnum rlopenxrEyeBoth
					keep_aspect_ratio: true].
		Raylib rlOpenXREnd].
	
	Transcript showln: 'Shutting down'.
	Raylib rlOpenXRShutdown.]
	ensure: [
		cam free.
		white free.
		blue free.
		red free.
		Raylib closeWindow.]
	
	
]
