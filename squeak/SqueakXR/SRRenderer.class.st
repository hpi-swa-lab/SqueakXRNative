Class {
	#name : #SRRenderer,
	#superclass : #Object,
	#classVars : [
		'ClearColor',
		'RendererClass'
	],
	#category : #'SqueakXR-Core'
}

{ #category : #'as yet unclassified' }
SRRenderer class >> clearColor [
	<preference: 'Clear color'
		category: 'SqueakXR'
		description: 'Clear color for the renderer'
		type: #Color>
	^ ClearColor ifNil: [ClearColor := Color gray]
]

{ #category : #'as yet unclassified' }
SRRenderer class >> clearColor: aColor [
	
	ClearColor := aColor
]

{ #category : #'as yet unclassified' }
SRRenderer class >> default [

	^ SRRaylibRenderer
]

{ #category : #'as yet unclassified' }
SRRenderer class >> rendererClass [
	<preference: 'Renderer'
		category: 'SqueakXR'
		description: 'Select rendering class'
		type: #Class>
	^ RendererClass ifNil: [SRRaylibRendererFlat]
]

{ #category : #'as yet unclassified' }
SRRenderer class >> rendererClass: aClass [
	
	^ RendererClass := aClass
]

{ #category : #'as yet unclassified' }
SRRenderer class >> selectRaylibXR [

	RendererClass := SRRaylibRendererXR.
]

{ #category : #'render-loop' }
SRRenderer >> completeFrame [
]

{ #category : #experiments }
SRRenderer >> pollAndroidEvents [

	<cdecl: void 'pollAndroidEvents' () module: 'squeakxrnative'>
	^ self externalCallFailed
]

{ #category : #'render-loop' }
SRRenderer >> prepareFrame [
]

{ #category : #rendering }
SRRenderer >> renderCubeTransformed: aMatrix4x4 withColor: aColor [

	self subclassResponsibility
]

{ #category : #rendering }
SRRenderer >> renderMesh: aMesh transform: aMatrix4x4 material: aMaterial [

	self subclassResponsibility
]

{ #category : #'render-loop' }
SRRenderer >> setup [
]

{ #category : #'render-loop' }
SRRenderer >> shutdown [
]

{ #category : #experiments }
SRRenderer >> simpleDrawLoop [

	"adapted from https://github.com/FireFlyForLife/rlOpenXR/blob/main/examples/1_hello_vr.c"
	
	| cam blue red white i |
	Raylib initWindowWidth: 1200 height: 900 title: 'SqueakXR'.
	
	cam := RlCamera3D externalNew
		position: (RlVector3 new x: 10; y: 10; z: 10);
		target: (RlVector3 new x: 0; y: 3; z: 0);
		up: (RlVector3 new x: 0; y: 1; z: 0);
		fovy: 45;
		projection: RlCameraProjection cameraPerspective.
	white := RlColor externalNew r: 255; g: 255; b: 255; a: 255.
	blue := RlColor externalNew r: 100; g: 100; b: 0; a: 255.
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
	
	i := 0.
	[Raylib windowShouldClose] whileFalse: [
		i := i + 1.
		"i \\ 1 = 0 ifTrue: [Transcript showln: 'xxxxxxxxxxxxxxx Rendering ', i asString]."
		"i = 10000 ifTrue: [^ self]."
		
		self pollAndroidEvents.
		
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
				drawCubePosition: (RlVector3 new x: -3; y: 0; z: ((DateAndTime now asDuration asMilliSeconds * 0.01) sin))
					width: 2
					height: 2
					length: 2
					color: red;
				drawGridSlices: 10 spacing: 1;
				endMode3D;
				rlOpenXRBlitToWindowEye: RlRLOpenXREyeEnum rlopenxrEyeBoth
					keep_aspect_ratio: true].
		Raylib rlOpenXREnd.
		1 milliSecond wait].
	
	Transcript showln: 'Shutting down'.
	Raylib rlOpenXRShutdown.]
	ensure: [
		cam free.
		white free.
		blue free.
		red free.
		Raylib closeWindow.]
	
	
]

{ #category : #experiments }
SRRenderer >> test [

	^ 102934
]
