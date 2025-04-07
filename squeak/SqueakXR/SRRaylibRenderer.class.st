Class {
	#name : #SRRaylibRenderer,
	#superclass : #SRRenderer,
	#instVars : [
		'clearColor',
		'camera'
	],
	#category : #'SqueakXR-Core'
}

{ #category : #accessing }
SRRaylibRenderer >> clearColor: aColor [

	clearColor := aColor asRlColor
]

{ #category : #'as yet unclassified' }
SRRaylibRenderer >> completeFrame [

	self completeFrameFlat
]

{ #category : #'as yet unclassified' }
SRRaylibRenderer >> completeFrameFlat [

	Raylib
		drawGridSlices: 10 spacing: 1;
		endMode3D;
		endDrawing.
]

{ #category : #initializing }
SRRaylibRenderer >> initialize [

	super initialize.
	
	self clearColor: Color white.
]

{ #category : #'as yet unclassified' }
SRRaylibRenderer >> prepareFrame [

	self prepareFrameFlat
]

{ #category : #'as yet unclassified' }
SRRaylibRenderer >> prepareFrameFlat [

	Raylib
		beginDrawing;
		clearBackgroundColor: clearColor;
		beginMode3DCamera: camera.
]

{ #category : #'as yet unclassified' }
SRRaylibRenderer >> renderCubeTransformed: aMatrix4x4 withColor: aColor [

	| scale rotation translate |
	scale := aMatrix4x4 scale.
	rotation := aMatrix4x4 rotation.
	translate := aMatrix4x4 translation.
	
	Raylib rlPushMatrix;
		rlTranslatefX: translate x y: translate y z: translate z;
		rlScalefX: scale x y: scale y z: scale z;
		rlRotatefAngle: rotation x x: 1 y: 0 z: 0;
		rlRotatefAngle: rotation y x: 0 y: 1 z: 0;
		rlRotatefAngle: rotation z x: 0 y: 0 z: 1.
	
	Raylib drawCubePosition: Vector3 zero asRlVector
		width: 1
		height: 1
		length: 1
		color: aColor asRlColor.
		
	Raylib rlPopMatrix.
]

{ #category : #'as yet unclassified' }
SRRaylibRenderer >> setup [

	self setupFlat
]

{ #category : #'as yet unclassified' }
SRRaylibRenderer >> setupFlat [

	Raylib initWindowWidth: 800 height: 450 title: 'Squeak 3D World'.
	
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

{ #category : #'as yet unclassified' }
SRRaylibRenderer >> shutdown [

	self shutdownFlat
]

{ #category : #'as yet unclassified' }
SRRaylibRenderer >> shutdownFlat [

	Raylib closeWindow.
]
