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
	#category : #'SqueakXR-Core'
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

{ #category : #initializing }
SRPlane >> initialize [

	super initialize.
	
	self material ifNil: [
		self material: SRMaterial new]
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

{ #category : #'as yet unclassified' }
SRPlane >> onCacheInvalidated [

	mesh := nil
]

{ #category : #rendering }
SRPlane >> renderOn: aSRRenderer [

	aSRRenderer
		renderMesh: self mesh
		transform: self globalTransform
		material: self material
]
