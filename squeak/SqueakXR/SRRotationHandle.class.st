Class {
	#name : #SRRotationHandle,
	#superclass : #SRObject,
	#instVars : [
		'meshObject'
	],
	#classVars : [
		'Mesh'
	],
	#category : #'SqueakXR-Halo'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 11/6/2026 13:50'
}
SRRotationHandle class >> mesh [

	^ Mesh ifNil: [
		Mesh := SRMesh withSource: (
			SRMeshSourceRaylibGen torusRadius: 0.05 size: 2 radSeg: 8 sides: 64
	)]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 11/5/2026 17:44'
}
SRRotationHandle >> axis [
	
	^ self forward
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 11/5/2026 17:32'
}
SRRotationHandle >> collisionGeometry [ 

	^ SRCollisionTorus new
		axis: self axis;
		major: self globalScale x;
		minor: self globalScale x / 10;
		center: self globalTranslation;
		object: self
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 11/6/2026 13:54'
}
SRRotationHandle >> initialize [ 

	super initialize.
	meshObject := SRMeshObject withMesh: self class mesh.
	meshObject material colDiffuse: Color red.
	self addChild: meshObject.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 11/5/2026 17:25'
}
SRRotationHandle >> step: deltaTime [ 

	self gizmoPainter gizmoWireTorus: self collisionGeometry color: Color black
]
