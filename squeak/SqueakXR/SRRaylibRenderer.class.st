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
SRRaylibRenderer >> prepareFrame [

	self subclassResponsibility
]

{ #category : #rendering }
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
			color: aColor muchDarker asRlColor.
		
		
	Raylib rlPopMatrix.
]

{ #category : #rendering }
SRRaylibRenderer >> renderMesh: aMesh transform: aMatrix4x4 material: aSRMaterial [

	Raylib
		drawMesh: aMesh
		material: aSRMaterial internalMaterial
		transform: aMatrix4x4 asRlMatrix
]

{ #category : #'render-loop' }
SRRaylibRenderer >> setup [

	self subclassResponsibility
]

{ #category : #'render-loop' }
SRRaylibRenderer >> shutdown [

	self subclassResponsibility 
]
