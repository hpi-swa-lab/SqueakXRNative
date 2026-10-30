Class {
	#name : #SRMaterial,
	#superclass : #Object,
	#instVars : [
		'internalMaterial',
		'shader',
		'texture',
		'cubemap',
		'isDirty',
		'mapsDirty'
	],
	#category : #'SqueakXR-Graphics-Material'
}

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'SqueakXR 6/29/2026 16:43'
}
SRMaterial class >> withTexture: anSRTexture [
	^ self new texture: anSRTexture; yourself
]

{
	#category : #maps,
	#'squeak_changestamp' : 'MCPServer (leo) 10/30/2026 15:55'
}
SRMaterial >> albedoMap [

	^ self mapAt: RlMaterialMapIndex materialMapAlbedo
]

{
	#category : #maps,
	#'squeak_changestamp' : 'MCPServer (leo) 10/30/2026 15:55'
}
SRMaterial >> brdfMap [

	^ self mapAt: RlMaterialMapIndex materialMapBrdf
]

{
	#category : #private,
	#'squeak_changestamp' : 'MCPServer (leo) 10/30/2026 15:55'
}
SRMaterial >> buildInternalMaterialFor: aSRRenderer [

	internalMaterial := Raylib loadMaterialDefault.
	shader ifNotNil: [
		internalMaterial shader: shader internalShader].
	mapsDirty := true.
	^ internalMaterial
]

{
	#category : #textures,
	#'squeak_changestamp' : 'MCPServer (leo) 10/30/2026 15:55'
}
SRMaterial >> cubemap [

	^ cubemap
]

{
	#category : #textures,
	#'squeak_changestamp' : 'MCPServer (leo) 10/30/2026 15:55'
}
SRMaterial >> cubemap: anSRTexture [

	self observeTexture: anSRTexture insteadOf: cubemap.
	cubemap := anSRTexture.
]

{
	#category : #maps,
	#'squeak_changestamp' : 'MCPServer (leo) 10/30/2026 15:55'
}
SRMaterial >> cubemapMap [

	^ self mapAt: RlMaterialMapIndex materialMapCubemap
]

{
	#category : #maps,
	#'squeak_changestamp' : 'MCPServer (leo) 10/30/2026 15:55'
}
SRMaterial >> emissionMap [

	^ self mapAt: RlMaterialMapIndex materialMapEmission
]

{ #category : #'as yet unclassified' }
SRMaterial >> finalize [

	self unloadInternalMaterial
]

{
	#category : #maps,
	#'squeak_changestamp' : 'MCPServer (leo) 10/30/2026 15:55'
}
SRMaterial >> heightMap [

	^ self mapAt: RlMaterialMapIndex materialMapHeight
]

{
	#category : #initializing,
	#'squeak_changestamp' : 'MCPServer (leo) 10/30/2026 15:55'
}
SRMaterial >> initialize [

	isDirty := true.
	mapsDirty := true.
]

{ #category : #accessing }
SRMaterial >> internalMaterial [

	^ internalMaterial
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer (leo) 10/30/2026 15:56'
}
SRMaterial >> internalMaterialFor: aSRRenderer [

	isDirty ifTrue: [
		aSRRenderer removeAt: self.
		isDirty := false].
	internalMaterial := aSRRenderer cacheAt: self ifAbsentPut: [self buildInternalMaterialFor: aSRRenderer].
	mapsDirty ifTrue: [self updateMaps].
	^ internalMaterial
]

{
	#category : #maps,
	#'squeak_changestamp' : 'MCPServer (leo) 10/30/2026 15:55'
}
SRMaterial >> irradianceMap [

	^ self mapAt: RlMaterialMapIndex materialMapIrradiance
]

{
	#category : #maps,
	#'squeak_changestamp' : 'MCPServer (leo) 10/30/2026 15:55'
}
SRMaterial >> mapAt: aMaterialMapIndex [

	^ RlMaterialMap fromHandle:
		internalMaterial maps getHandle + (aMaterialMapIndex * RlMaterialMap externalType byteSize)
]

{
	#category : #maps,
	#'squeak_changestamp' : 'MCPServer (leo) 10/30/2026 15:55'
}
SRMaterial >> metalnessMap [

	^ self mapAt: RlMaterialMapIndex materialMapMetalness
]

{
	#category : #maps,
	#'squeak_changestamp' : 'MCPServer (leo) 10/30/2026 15:55'
}
SRMaterial >> normalMap [

	^ self mapAt: RlMaterialMapIndex materialMapNormal
]

{
	#category : #textures,
	#'squeak_changestamp' : 'MCPServer (leo) 10/30/2026 15:55'
}
SRMaterial >> observeTexture: newTexture insteadOf: oldTexture [

	oldTexture ifNotNil: [oldTexture removeDependent: self].
	newTexture ifNotNil: [newTexture addDependent: self].
	mapsDirty := true.
]

{
	#category : #maps,
	#'squeak_changestamp' : 'MCPServer (leo) 10/30/2026 15:55'
}
SRMaterial >> occlusionMap [

	^ self mapAt: RlMaterialMapIndex materialMapOcclusion
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer (leo) 10/30/2026 15:55'
}
SRMaterial >> onCacheInvalidated [

	internalMaterial := nil.
	shader ifNotNil: [shader onCacheInvalidated].
	texture ifNotNil: [texture onCacheInvalidated].
	cubemap ifNotNil: [cubemap onCacheInvalidated].
	mapsDirty := true.
]

{
	#category : #maps,
	#'squeak_changestamp' : 'MCPServer (leo) 10/30/2026 15:55'
}
SRMaterial >> prefilterMap [

	^ self mapAt: RlMaterialMapIndex materialMapPrefilter
]

{
	#category : #maps,
	#'squeak_changestamp' : 'MCPServer (leo) 10/30/2026 15:55'
}
SRMaterial >> roughnessMap [

	^ self mapAt: RlMaterialMapIndex materialMapRoughness
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 6/8/2026 15:07'
}
SRMaterial >> shader [

	^ shader
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer (leo) 10/15/2026 15:14'
}
SRMaterial >> shader: aShader [

	shader := aShader.
	isDirty := true.
]

{
	#category : #textures,
	#'squeak_changestamp' : 'SqueakXR 6/29/2026 16:42'
}
SRMaterial >> texture [
	^ texture
]

{
	#category : #textures,
	#'squeak_changestamp' : 'MCPServer (leo) 10/30/2026 15:55'
}
SRMaterial >> texture: anSRTexture [

	self observeTexture: anSRTexture insteadOf: texture.
	texture := anSRTexture.
	^ self
]

{ #category : #'as yet unclassified' }
SRMaterial >> unloadInternalMaterial [

	self internalMaterial ifNotNil: [Raylib unloadMaterial: self internalMaterial]
]

{
	#category : #updating,
	#'squeak_changestamp' : 'MCPServer (leo) 10/30/2026 15:55'
}
SRMaterial >> update: aSymbol [

	aSymbol = #textureChanged ifTrue: [mapsDirty := true].
]

{
	#category : #private,
	#'squeak_changestamp' : 'MCPServer (leo) 10/30/2026 15:55'
}
SRMaterial >> updateMaps [

	texture ifNotNil: [self albedoMap texture: texture internalTexture].
	cubemap ifNotNil: [self cubemapMap texture: cubemap internalTexture].
	mapsDirty := false.
]
