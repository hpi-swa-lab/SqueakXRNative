"
An SRObject that draws an SRMesh with an SRMaterial at its own world transform. One DrawMesh call per frame per object; the mesh stays GPU-resident across frames and survives image save/restart (via SRMesh and SRTexture's shutDown/startUp hooks).

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
	#'squeak_changestamp' : '<historical>'
}

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
	#'squeak_changestamp' : 'MCPServer 5/28/2026 17:36'
}
SRMeshObject >> mesh: anSRMesh [
	mesh := anSRMesh
]

{
	#category : #lifecycle,
	#'squeak_changestamp' : 'MCPServer 5/28/2026 18:31'
}
SRMeshObject >> onCacheInvalidated [
	"Renderer cache is cleared (image restart). We hold no GPU state of our own -- mesh / material / texture are all rebuilt lazily from the renderer cache. So nothing to do here besides super."

	super onCacheInvalidated
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'MCPServer 5/28/2026 18:33'
}
SRMeshObject >> renderOn: aSRRenderer [
	"Force cache-managed lazy rebuild of mesh + material+texture, then call the renderer's standard renderMesh:transform:material: which itself reads the (now-refreshed) internalMaterial off the SRMaterial wrapper."

	mesh ifNil: [^ self].
	material ifNil: [^ self].
	"Side-effect: ensure cache entries exist and internalMaterial ivar is fresh."
	material internalMaterialFor: aSRRenderer.
	aSRRenderer withoutBackfaceCullingDo: [
		aSRRenderer
			renderMesh: (mesh internalMeshFor: aSRRenderer)
			transform: self globalTransform
			material: material]
]
