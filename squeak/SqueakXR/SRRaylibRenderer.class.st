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

	| scale |
	scale := aMatrix4x4 scale.
	
	Raylib drawCubePosition: aMatrix4x4 translation asRlVector
		width: scale x
		height: scale y
		length: scale z
		color: aColor asRlColor
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
