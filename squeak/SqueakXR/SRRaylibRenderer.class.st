Class {
	#name : #SRRaylibRenderer,
	#superclass : #SRRenderer,
	#instVars : [
		'clearColor',
		'camera'
	],
	#category : #'SqueakXR-Core'
}

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 4/22/2026 15:24'
}
SRRaylibRenderer >> camera [
	^camera
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 10/9/2025 17:44'
}
SRRaylibRenderer >> cameraPosition [

	^ camera position
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 10/9/2025 17:44'
}
SRRaylibRenderer >> cameraTarget [

	^ camera target
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 10/9/2025 17:44'
}
SRRaylibRenderer >> cameraUp [

	^ camera up
]

{ #category : #accessing }
SRRaylibRenderer >> clearColor: aColor [

	clearColor := aColor asRlColor
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
	#'squeak_changestamp' : 'lege 3/17/2026 16:16'
}
SRRaylibRenderer >> enableBackfaceCulling [

	Raylib rlEnableBackfaceCulling.
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
	#'squeak_changestamp' : 'lege 4/2/2026 13:20'
}
SRRaylibRenderer >> renderCubeTransformed: aMatrix4x4 withColor: aColor [

	self withTransform: aMatrix4x4 do: [
		Raylib
			drawCubePosition: Vector3 zero asRlVector
				width: 1
				height: 1
				length: 1
				color: aColor asRlColor;
			drawCubeWiresPosition: Vector3 zero asRlVector
				width: 1
				height: 1
				length: 1
				color: aColor muchDarker asRlColor].
]

{ #category : #rendering }
SRRaylibRenderer >> renderMesh: aMesh transform: aMatrix4x4 material: aSRMaterial [

	Raylib
		drawMesh: aMesh
		material: aSRMaterial internalMaterial
		transform: aMatrix4x4 asRlMatrix
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'lege 4/2/2026 13:20'
}
SRRaylibRenderer >> renderSphereTransformed: aMatrix4x4 withColor: aColor [

	self withTransform: aMatrix4x4 do: [
		Raylib
			drawSphereExCenterPos: Vector3 zero asRlVector
				radius: 0.5
				rings: 16
				slices: 16
				color: aColor asRlColor;
			drawSphereWiresCenterPos: Vector3 zero asRlVector
				radius: 0.5
				rings: 16
				slices: 16
				color: aColor thriceDarker asRlColor].
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
	#'squeak_changestamp' : 'lege 4/2/2026 13:30'
}
SRRaylibRenderer >> renderString: aString transformed: aMatrix4x4 color: aColor font: aFont [ 

	self withTransform: aMatrix4x4 do: [
		Raylib
			drawTextWithFont: (aFont ifNil: [Raylib getFontDefault])
			text: aString
			position: Vector3 zero asRlVector
			size: 1
			fontSpacing: 0.1
			lineSpacing: 0.1
			backface: true
			color: aColor asRlColor].
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
