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

{ #category : #'render-loop' }
SRRaylibRenderer >> completeFrame [

	self subclassResponsibility
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

{ #category : #rendering }
SRRaylibRenderer >> renderCubeTransformed: aMatrix4x4 withColor: aColor [

	Raylib
		rlPushMatrix;
		rlMultMatrixfMatf: aMatrix4x4 transposed;
		drawCubePosition: Vector3 zero asRlVector
			width: 1
			height: 1
			length: 1
			color: aColor asRlColor;
		drawCubeWiresPosition: Vector3 zero asRlVector
			width: 1
			height: 1
			length: 1
			color: aColor muchDarker asRlColor;
		rlPopMatrix.
]

{ #category : #rendering }
SRRaylibRenderer >> renderMesh: aMesh transform: aMatrix4x4 material: aSRMaterial [

	Raylib
		drawMesh: aMesh
		material: aSRMaterial internalMaterial
		transform: aMatrix4x4 asRlMatrix
]

{ #category : #rendering }
SRRaylibRenderer >> renderSphereTransformed: aMatrix4x4 withColor: aColor [

	Raylib
		rlPushMatrix;
		rlMultMatrixfMatf: aMatrix4x4 transposed;
		drawSphereExCenterPos: Vector3 zero asRlVector
			radius: 0.5
			rings: 16
			slices: 16
			color: aColor asRlColor;
		drawSphereWiresCenterPos: Vector3 zero asRlVector
			radius: 0.5
			rings: 16
			slices: 16
			color: aColor thriceDarker asRlColor;
		rlPopMatrix.
]

{ #category : #'render-loop' }
SRRaylibRenderer >> setup [

	self subclassResponsibility
]

{ #category : #'render-loop' }
SRRaylibRenderer >> shutdown [

	self subclassResponsibility 
]
