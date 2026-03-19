Class {
	#name : #SRPlane,
	#superclass : #SRObject,
	#instVars : [
		'material',
		'mesh'
	],
	#classVars : [
		'Mesh'
	],
	#category : #'SqueakXR-Objects'
}

{ #category : #'as yet unclassified' }
SRPlane class >> mesh [

	"TODO: Cache mesh without it becoming invalid upon restarting image"
	"^ Mesh ifNil: [
		Mesh := Raylib genMeshPlaneWidth: 1 length: 1 resX: 4 resZ: 4]"
	^ Raylib genMeshPlaneWidth: 1 length: 1 resX: 4 resZ: 4
]

{ #category : #'as yet unclassified' }
SRPlane class >> withMaterial: aSRMaterial [

	self basicNew
		material: aSRMaterial;
		initialize
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 11/3/2025 18:02'
}
SRPlane >> collisionGeometry [

	| scale |
	"TODO: could be cached"
	scale := self scale.
	^ (SRCollisionPlane
		point: self globalTranslation
		normal: self normal
		up: self planeUp
		width: scale x
		height: scale z)
		object: self
]

{ #category : #accessing }
SRPlane >> height [

	^ self scale z
]

{ #category : #lifecycle }
SRPlane >> initialize [

	super initialize.
	
	material := SRMaterial new.
]

{ #category : #accessing }
SRPlane >> material [
	
	^ material
]

{ #category : #accessing }
SRPlane >> material: aSRMaterial [

	material := aSRMaterial
]

{ #category : #accessing }
SRPlane >> mesh [

	^ self world cacheAt: #planeMesh ifAbsentPut: [self class mesh]
	"^ mesh ifNil: [
		mesh := self world cacheAt: #planeMesh ifAbsentPut: [self class mesh]]"
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 2/23/2026 16:05'
}
SRPlane >> normal [

	^ (self globalTransform localDirToGlobal: Vector3 up) normalize
]

{ #category : #lifecycle }
SRPlane >> onCacheInvalidated [

	super onCacheInvalidated.

	mesh := nil
]

{ #category : #lifecycle }
SRPlane >> onWorldStarted [

	super onWorldStarted.
	
	self material: SRMaterial new.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 11/3/2025 18:02'
}
SRPlane >> planeUp [

	^ (self globalTransform localDirToGlobal: 0 @ 0 @ 1) normalize
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'lege 3/17/2026 16:22'
}
SRPlane >> renderOn: aSRRenderer [

	aSRRenderer withoutBackfaceCullingDo: [
		aSRRenderer
			renderMesh: self mesh
			transform: self globalTransform
			material: self material].
]

{ #category : #accessing }
SRPlane >> width [

	^ self scale x
]
