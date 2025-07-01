Class {
	#name : #SRRaylibRendererFlat,
	#superclass : #SRRaylibRenderer,
	#category : #'SqueakXR-Core'
}

{ #category : #'render-loop' }
SRRaylibRendererFlat >> completeFrame [

	Raylib updateCamera: camera mode: RlCameraMode cameraFree.

	Raylib
		drawGridSlices: 10 spacing: 1;
		endMode3D;
		endDrawing.
]

{ #category : #'render-loop' }
SRRaylibRendererFlat >> prepareFrame [

	Raylib
		beginDrawing;
		clearBackgroundColor: clearColor;
		beginMode3DCamera: camera.
	
	^ true
]

{ #category : #'render-loop' }
SRRaylibRendererFlat >> setup [

	Raylib initWindowWidth: 800 height: 450 title: 'Squeak 3D World';
		setWindowMonitor: (Raylib getMonitorCount < self class startMonitor
			ifTrue: [0]
			ifFalse: [self class startMonitor]).
	
	camera := RlCamera3D new
		position: (10 @ 10 @ 10) asRlVector;
		target: Vector3 zero asRlVector;
		up: Vector3 up asRlVector;
		fovy: 45;
		projection: RlCameraProjection cameraPerspective.
	
	Raylib
		"disableCursor;"
		setTargetFPS: -1.
]

{ #category : #'render-loop' }
SRRaylibRendererFlat >> shutdown [

	Raylib closeWindow.
]
