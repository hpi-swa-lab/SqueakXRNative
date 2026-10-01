Class {
	#name : #SRRaylibRenderer,
	#superclass : #SRRenderer,
	#instVars : [
		'clearColor',
		'camera'
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

{ #category : #initializing }
SRRaylibRenderer >> initialize [

	super initialize.
	
	self clearColor: self class clearColor.
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
	#'squeak_changestamp' : 'lege 7/7/2026 18:02'
}
SRRaylibRenderer >> renderMesh: aSRMesh transform: aMatrix4x4 material: aSRMaterial [

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
	#'squeak_changestamp' : 'MCPServer 9/29/2026 15:09'
}
SRRaylibRenderer >> renderWireCubeTransformed: aMatrix4x4 withColor: aColor [

	self withTransform: aMatrix4x4 do: [
		Raylib
			drawCubeWiresPosition: self class rlVectorZero
				width: 1
				height: 1
				length: 1
				color: (self class rlColorFor_1: aColor muchDarker)].
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
