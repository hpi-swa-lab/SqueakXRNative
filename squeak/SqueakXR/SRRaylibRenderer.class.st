Class {
	#name : #SRRaylibRenderer,
	#superclass : #SRRenderer,
	#instVars : [
		'clearColor',
		'camera',
		'environment',
		'lights',
		'viewPosition',
		'litShaders'
	],
	#classVars : [
		'CachedColor1',
		'CachedColor2',
		'CachedVector1',
		'CachedVector2',
		'CachedVector3',
		'CachedVectorZero'
	],
	#category : #'SqueakXR-Graphics-Renderer'
}

{
	#category : #'shared rl objects',
	#'squeak_changestamp' : 'MCPServer 9/29/2026 15:18'
}
SRRaylibRenderer class >> fill: anRlColor withColor: aColor [

	^ anRlColor
		r: (aColor red * 255) asInteger;
		g: (aColor green * 255) asInteger;
		b: (aColor blue * 255) asInteger;
		a: (aColor alpha * 255) asInteger;
		yourself
]

{
	#category : #'shared rl objects',
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 15:00'
}
SRRaylibRenderer class >> fill: anRlMatrix withMatrix4x4: aMatrix4x4 [

	^ anRlMatrix
		m0: aMatrix4x4 a11; m4: aMatrix4x4 a12; m8: aMatrix4x4 a13; m12: aMatrix4x4 a14;
		m1: aMatrix4x4 a21; m5: aMatrix4x4 a22; m9: aMatrix4x4 a23; m13: aMatrix4x4 a24;
		m2: aMatrix4x4 a31; m6: aMatrix4x4 a32; m10: aMatrix4x4 a33; m14: aMatrix4x4 a34;
		m3: aMatrix4x4 a41; m7: aMatrix4x4 a42; m11: aMatrix4x4 a43; m15: aMatrix4x4 a44;
		yourself
]

{
	#category : #'shared rl objects',
	#'squeak_changestamp' : 'MCPServer 9/29/2026 15:18'
}
SRRaylibRenderer class >> fill: anRlVector3 withVector3: aVector3 [

	^ anRlVector3
		x: aVector3 x;
		y: aVector3 y;
		z: aVector3 z;
		yourself
]

{
	#category : #'class initialization',
	#'squeak_changestamp' : 'MCPServer 9/29/2026 15:18'
}
SRRaylibRenderer class >> initialize [

	CachedVectorZero := RlVector3 new x: 0.0; y: 0.0; z: 0.0; yourself.
	CachedVector1 := RlVector3 new.
	CachedVector2 := RlVector3 new.
	CachedVector3 := RlVector3 new.
	CachedColor1 := RlColor new.
	CachedColor2 := RlColor new.
]

{
	#category : #'shared rl objects',
	#'squeak_changestamp' : 'MCPServer 9/29/2026 15:18'
}
SRRaylibRenderer class >> rlColorFor_1: aColor [

	^ self fill: CachedColor1 withColor: aColor
]

{
	#category : #'shared rl objects',
	#'squeak_changestamp' : 'MCPServer 9/29/2026 15:18'
}
SRRaylibRenderer class >> rlColorFor_2: aColor [

	^ self fill: CachedColor2 withColor: aColor
]

{
	#category : #'shared rl objects',
	#'squeak_changestamp' : 'MCPServer 9/29/2026 15:18'
}
SRRaylibRenderer class >> rlVector3For_1: aVector3 [

	^ self fill: CachedVector1 withVector3: aVector3
]

{
	#category : #'shared rl objects',
	#'squeak_changestamp' : 'MCPServer 9/29/2026 15:18'
}
SRRaylibRenderer class >> rlVector3For_2: aVector3 [

	^ self fill: CachedVector2 withVector3: aVector3
]

{
	#category : #'shared rl objects',
	#'squeak_changestamp' : 'MCPServer 9/29/2026 15:18'
}
SRRaylibRenderer class >> rlVector3For_3: aVector3 [

	^ self fill: CachedVector3 withVector3: aVector3
]

{
	#category : #'shared rl objects',
	#'squeak_changestamp' : 'MCPServer 9/29/2026 15:18'
}
SRRaylibRenderer class >> rlVectorZero [

	^ CachedVectorZero
]

{
	#category : #lighting,
	#'squeak_changestamp' : 'leo 11/2/2026 16:50'
}
SRRaylibRenderer >> applyLightingTo: aSRShader [

	(litShaders includes: aSRShader) ifTrue: [^ self].
	litShaders add: aSRShader.
	aSRShader
		uploadLights: lights
		ambientColor: environment ambientColor
		viewPosition: viewPosition.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 7/16/2026 17:13'
}
SRRaylibRenderer >> camera [

	^ camera
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 9/29/2026 15:18'
}
SRRaylibRenderer >> clearColor: aColor [

	clearColor
		ifNil: [clearColor := RlColor new].
	self class fill: clearColor withColor: aColor
]

{
	#category : #info,
	#'squeak_changestamp' : 'phkeese 11/13/2026 13:51'
}
SRRaylibRenderer >> clearDepth [ 

	Raylib
		rlDrawRenderBatchActive;
		clearDepthBuffer.
]

{
	#category : #lighting,
	#'squeak_changestamp' : 'MCPServer (leo) 11/2/2026 15:47'
}
SRRaylibRenderer >> clearLitShaders [

	litShaders removeAll.
]

{ #category : #'render-loop' }
SRRaylibRenderer >> completeFrame [

	self subclassResponsibility
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'lege 3/17/2026 16:16'
}
SRRaylibRenderer >> disableBackfaceCulling [

	Raylib rlDisableBackfaceCulling.
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'leo 9/8/2026 18:16'
}
SRRaylibRenderer >> disableDepthTest [

	"Render batch must be flushed so previous geometry is rendered correctly."
	Raylib
		rlDrawRenderBatchActive;
		rlDisableDepthTest.
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 15:00'
}
SRRaylibRenderer >> drawGrid [

	| rlColor slices spacing half |
	rlColor := SRRenderer gridColor asRlColor.
	slices := SRRenderer gridSlices.
	spacing := SRRenderer gridSpacing.
	half := slices / 2.0 * spacing.
	0 to: slices do: [:i |
		| offset |
		offset := i * spacing - half.
		Raylib
			drawLine3DStartPos: (offset @ 0 @ half negated) asRlVector
			endPos: (offset @ 0 @ half) asRlVector
			color: rlColor.
		Raylib
			drawLine3DStartPos: (half negated @ 0 @ offset) asRlVector
			endPos: (half @ 0 @ offset) asRlVector
			color: rlColor].
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'lege 3/17/2026 16:16'
}
SRRaylibRenderer >> enableBackfaceCulling [

	Raylib rlEnableBackfaceCulling.
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'leo 9/8/2026 18:15'
}
SRRaylibRenderer >> enableDepthTest [

	"Render batch must be flushed so previous geometry is rendered correctly."
	Raylib
		rlDrawRenderBatchActive;
		rlEnableDepthTest.
]

{
	#category : #lighting,
	#'squeak_changestamp' : 'MCPServer (leo) 11/2/2026 15:47'
}
SRRaylibRenderer >> environment: aVisualEnvironment lights: aCollection [

	environment := aVisualEnvironment.
	lights := aCollection.
	self clearColor: aVisualEnvironment clearColor.
]

{
	#category : #initializing,
	#'squeak_changestamp' : 'MCPServer (leo) 11/2/2026 14:26'
}
SRRaylibRenderer >> initialize [

	super initialize.

	litShaders := IdentitySet new.
	self environment: SRVisualEnvironment new lights: #().

	SRRenderer mirrorPlaced: false.
]

{
	#category : #window,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 15:00'
}
SRRaylibRenderer >> mirrorAspect [

	^ 16 / 9
]

{
	#category : #window,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 15:00'
}
SRRaylibRenderer >> moveWindowToMonitor: monitorIndex [

	| origin inset extent width height |
	origin := Raylib getMonitorPositionMonitor: monitorIndex.
	extent := (Raylib getMonitorWidthMonitor: monitorIndex)
		@ (Raylib getMonitorHeightMonitor: monitorIndex).

	inset := 60.
	height := extent y - (inset * 2).
	width := (height * self mirrorAspect) rounded.
	width > (extent x - (inset * 2)) ifTrue: [
		width := extent x - (inset * 2).
		height := (width / self mirrorAspect) rounded].
	Raylib
		setWindowPositionX: origin x asInteger + (extent x - width // 2)
			y: origin y asInteger + inset;
		setWindowSizeWidth: width height: height.
]

{
	#category : #window,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 15:00'
}
SRRaylibRenderer >> placeMirrorWindowOnce [

	SRRenderer mirrorPlaced ifTrue: [^ self].
	SRRenderer mirrorPlaced: true.
	SRWorld current ifNotNil: [:world |
		world addDeferredFrameMessage: [
			self moveWindowToMonitor: SRRenderer mirrorMonitor]].
]

{ #category : #'render-loop' }
SRRaylibRenderer >> prepareFrame: cameraTransform [

	self subclassResponsibility
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'MCPServer 9/29/2026 15:10'
}
SRRaylibRenderer >> render2DString: aString position: aPoint color: aColor fontSize: aNumber [

	Raylib
		drawText: aString
		posX: aPoint x
		posY: aPoint y
		fontSize: aNumber
		color: (self class rlColorFor_1: aColor)
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'phkeese 11/5/2026 17:41'
}
SRRaylibRenderer >> renderCircleCenter: center radius: radius axis: axis color: color [
	
	| T R |
	R := Matrix4x4 at: axis up: Vector3 up.
	T := Matrix4x4 withOffset: center.
	self withTransform: T * R do: [
		Raylib drawCircle3DCenter: (self class rlVectorZero) 
		radius: radius 
		rotationAxis: (self class rlVector3For_2: 0@0@1)
		rotationAngle: 0 
		color: (self class rlColorFor_1: color).
		Raylib drawLine3DStartPos: (self class rlVectorZero) endPos: (self class rlVector3For_2: 0@0@1) color: (self class rlColorFor_1: color).
	]
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'MCPServer 9/29/2026 15:09'
}
SRRaylibRenderer >> renderCubeTransformed: aMatrix4x4 withColor: aColor [

	self withTransform: aMatrix4x4 do: [
		Raylib
			drawCubePosition: self class rlVectorZero
				width: 1
				height: 1
				length: 1
				color: (self class rlColorFor_1: aColor);
			drawCubeWiresPosition: self class rlVectorZero
				width: 1
				height: 1
				length: 1
				color: (self class rlColorFor_2: aColor muchDarker)].
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'MCPServer (leo) 11/2/2026 17:16'
}
SRRaylibRenderer >> renderCubeWiresTransformed: aMatrix4x4 withColor: aColor [

	self withTransform: aMatrix4x4 do: [
		Raylib
			drawCubeWiresPosition: self class rlVectorZero
				width: 1
				height: 1
				length: 1
				color: (self class rlColorFor_1: aColor)].
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:20'
}
SRRaylibRenderer >> renderFastCube: anSRFastCube [
	"The same calls as #renderCubeTransformed:withColor:, but every argument is
	state of the cube, so the draw allocates nothing."

	Raylib rlPushMatrix;
		rlMultMatrixfMatf: anSRFastCube glMatrix;
		drawCubePosition: SRFastCube sharedZero
			width: 1
			height: 1
			length: 1
			color: anSRFastCube rlColor.
	anSRFastCube drawWires ifTrue: [
		Raylib
			drawCubeWiresPosition: SRFastCube sharedZero
			width: 1
			height: 1
			length: 1
			color: anSRFastCube rlWireColor].
	Raylib rlPopMatrix.
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'phkeese 11/4/2026 14:08'
}
SRRaylibRenderer >> renderGridSlices: anInt spacing: aNumber [

	Raylib drawGridSlices: anInt spacing: aNumber
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'phkeese 9/30/2026 15:25'
}
SRRaylibRenderer >> renderLineFrom: aPoint to: anEndPoint color: aColor [
	
	Raylib drawLine3DStartPos: aPoint asRlVector endPos: anEndPoint asRlVector color: aColor asRlColor
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'MCPServer (leo) 11/2/2026 17:16'
}
SRRaylibRenderer >> renderLineFrom: startVector3 to: endVector3 withColor: aColor [

	Raylib
		drawLine3DStartPos: (self class rlVector3For_1: startVector3)
		endPos: (self class rlVector3For_2: endVector3)
		color: (self class rlColorFor_1: aColor).
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'MCPServer (leo) 10/30/2026 17:03'
}
SRRaylibRenderer >> renderMesh: aSRMesh transform: aMatrix4x4 material: aSRMaterial [

	aSRMaterial shader ifNotNil: [:shader | self applyLightingTo: shader].
	Raylib
		drawMesh: aSRMesh internalMesh
		material: (aSRMaterial internalMaterialFor: self)
		transform: aMatrix4x4 asRlMatrix
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'MCPServer 9/29/2026 15:09'
}
SRRaylibRenderer >> renderPlainCubeTransformed: aMatrix4x4 withColor: aColor [

	self withTransform: aMatrix4x4 do: [
		Raylib
			drawCubePosition: self class rlVectorZero
				width: 1
				height: 1
				length: 1
				color: (self class rlColorFor_1: aColor)].
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'MCPServer 9/29/2026 15:10'
}
SRRaylibRenderer >> renderSphereTransformed: aMatrix4x4 withColor: aColor [

	self withTransform: aMatrix4x4 do: [
		Raylib
			drawSphereExCenterPos: self class rlVectorZero
				radius: 0.5
				rings: 16
				slices: 16
				color: (self class rlColorFor_1: aColor);
			drawSphereWiresCenterPos: self class rlVectorZero
				radius: 0.5
				rings: 16
				slices: 16
				color: (self class rlColorFor_2: aColor thriceDarker)].
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'MCPServer (leo) 11/2/2026 17:16'
}
SRRaylibRenderer >> renderSphereWiresTransformed: aMatrix4x4 withColor: aColor [

	self withTransform: aMatrix4x4 do: [
		Raylib
			drawSphereWiresCenterPos: self class rlVectorZero
				radius: 0.5
				rings: 16
				slices: 16
				color: (self class rlColorFor_1: aColor)].
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'lege 4/2/2026 13:31'
}
SRRaylibRenderer >> renderString: aString transformed: aMatrix4x4 color: aColor [

	self renderString: aString transformed: aMatrix4x4 color: aColor font: nil 
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'MCPServer 9/29/2026 15:10'
}
SRRaylibRenderer >> renderString: aString transformed: aMatrix4x4 color: aColor font: aFont [ 

	self withTransform: aMatrix4x4 do: [
		Raylib
			drawTextWithFont: (aFont ifNil: [Raylib getFontDefault])
			text: aString
			position: self class rlVectorZero
			size: 1
			fontSpacing: 0.1
			lineSpacing: 0.1
			backface: true
			color: (self class rlColorFor_1: aColor)].
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'phkeese 10/21/2026 16:24'
}
SRRaylibRenderer >> renderWireCubeTransformed: aMatrix4x4 withColor: aColor [

	self withTransform: aMatrix4x4 do: [
		Raylib
			drawCubeWiresPosition: self class rlVectorZero
				width: 1
				height: 1
				length: 1
				color: (self class rlColorFor_1: aColor)].
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'phkeese 9/16/2026 14:54'
}
SRRaylibRenderer >> renderWireSphereTransformed: aMatrix4x4 withColor: aColor [

	self withTransform: aMatrix4x4 do: [
		Raylib
			drawSphereWiresCenterPos: Vector3 zero asRlVector
				radius: 0.5
				rings: 16
				slices: 16
				color: aColor asRlColor
	].
]

{ #category : #'render-loop' }
SRRaylibRenderer >> setup [

	self subclassResponsibility
]

{
	#category : #info,
	#'squeak_changestamp' : 'lege 3/11/2026 15:02'
}
SRRaylibRenderer >> shaderVersion [

	self subclassResponsibility
]

{ #category : #'render-loop' }
SRRaylibRenderer >> shutdown [

	self subclassResponsibility 
]

{
	#category : #'render-loop',
	#'squeak_changestamp' : 'MCPServer (leo) 10/30/2026 17:03'
}
SRRaylibRenderer >> updateCamera: cameraTransform [

	| forward up |
	viewPosition := cameraTransform translation.
	forward := cameraTransform localDirToGlobal: Vector3 forward.
	up := cameraTransform localDirToGlobal: Vector3 up.
	camera
		position: (self class rlVector3For_1: viewPosition);
		target: (self class rlVector3For_2: viewPosition + forward);
		up: (self class rlVector3For_3: up).
]
