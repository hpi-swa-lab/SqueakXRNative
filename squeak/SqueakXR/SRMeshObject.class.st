"
An SRObject that draws an SRMesh with an SRMaterial at its own world transform. One DrawMesh call per frame per object.

ivars:
  mesh      an SRMesh
  material  an SRMaterial
"
Class {
	#name : #SRMeshObject,
	#superclass : #SRObject,
	#instVars : [
		'mesh',
		'material'
	],
	#category : #'SqueakXR-Objects',
	#'squeak_changestamp' : 'lege 7/15/2026 16:17'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 7/8/2026 14:27'
}
SRMeshObject class >> fromSource: aSRMeshSource [

	^ self withMesh: (SRMesh withSource: aSRMeshSource)
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 7/8/2026 14:26'
}
SRMeshObject class >> withMesh: aSRMesh [

	^ self new mesh: aSRMesh
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'MCPServer 5/28/2026 17:36'
}
SRMeshObject >> initialize [
	super initialize.
	material := SRMaterial new
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 5/28/2026 17:36'
}
SRMeshObject >> material [
	^ material
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 5/28/2026 17:36'
}
SRMeshObject >> material: anSRMaterial [
	material := anSRMaterial
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 5/28/2026 17:36'
}
SRMeshObject >> mesh [
	^ mesh
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 7/15/2026 14:49'
}
SRMeshObject >> mesh: anSRMesh [

	mesh := anSRMesh
]

{
	#category : #lifecycle,
	#'squeak_changestamp' : 'lege 7/15/2026 19:04'
}
SRMeshObject >> onCacheInvalidated [

	super onCacheInvalidated.
	
	self mesh ifNotNil: #onCacheInvalidated.
	self material onCacheInvalidated.
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'lege 7/15/2026 14:08'
}
SRMeshObject >> renderOn: aSRRenderer [

	mesh ifNil: [^ self].
	material ifNil: [^ self].
	aSRRenderer withoutBackfaceCullingDo: [
		aSRRenderer
			renderMesh: self mesh
			transform: self globalTransform
			material: material].
]
