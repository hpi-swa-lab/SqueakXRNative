Class {
	#name : #SRPlane,
	#superclass : #SRObject,
	#instVars : [
		'material',
		'mesh',
		'meshObject'
	],
	#classVars : [
		'Mesh'
	],
	#category : #'SqueakXR-Objects'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 7/15/2026 15:28'
}
SRPlane class >> mesh [

	^ Mesh ifNil: [
		Mesh := SRMesh withSource: (
			SRMeshSourceRaylibGen planeWidth: 1 length: 1 widthSections: 4 lengthSections: 4)]
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

{
	#category : #lifecycle,
	#'squeak_changestamp' : 'lege 7/15/2026 15:26'
}
SRPlane >> initialize [

	super initialize.
	
	meshObject := SRMeshObject withMesh: self class mesh.
	self addChild: meshObject.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 7/15/2026 14:13'
}
SRPlane >> material [
	
	^ meshObject material
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 7/15/2026 14:13'
}
SRPlane >> material: aSRMaterial [

	meshObject material: aSRMaterial
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

{
	#category : #lifecycle,
	#'squeak_changestamp' : 'lege 7/15/2026 15:44'
}
SRPlane >> onWorldStarted [

	super onWorldStarted.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 11/3/2025 18:02'
}
SRPlane >> planeUp [

	^ (self globalTransform localDirToGlobal: 0 @ 0 @ 1) normalize
]

{ #category : #accessing }
SRPlane >> width [

	^ self scale x
]
