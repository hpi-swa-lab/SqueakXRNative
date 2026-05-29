Class {
	#name : #SRMaterial,
	#superclass : #Object,
	#instVars : [
		'internalMaterial',
		'shader',
		'srTexture'
	],
	#category : #'SqueakXR-Core'
}

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'MCPServer 5/28/2026 17:36'
}
SRMaterial class >> withTexture: anSRTexture [
	^ self new srTexture: anSRTexture; yourself
]

{
	#category : #private,
	#'squeak_changestamp' : 'MCPServer 5/29/2026 13:24'
}
SRMaterial >> buildInternalMaterialFor: aSRRenderer [
	"Build a fresh RlMaterial and bind the SRTexture (if any) to its diffuse map. Both the RlMaterial and the underlying RlTexture come from cache misses, so they're always fresh for the current GL context. If a custom shader was previously assigned (via vertexShader:fragmentShader: or shader:), re-bind it; otherwise raylib's default shader stays in place."
	| sh |
	internalMaterial := Raylib loadMaterialDefault.
	srTexture ifNotNil: [
		internalMaterial maps texture: (srTexture internalTextureFor: aSRRenderer)].
	shader ifNotNil: [
		sh := (shader respondsTo: #internalShader)
			ifTrue: [shader internalShader]
			ifFalse: [shader].
		internalMaterial shader: sh].
	^ internalMaterial
]

{ #category : #'as yet unclassified' }
SRMaterial >> finalize [

	self unloadInternalMaterial
]

{
	#category : #initializing,
	#'squeak_changestamp' : 'MCPServer 5/28/2026 18:30'
}
SRMaterial >> initialize [
	"Do NOT call loadMaterialDefault here -- that's GL work and would crash during image restart before the GL context is up. The real RlMaterial is built lazily by internalMaterialFor: via the renderer cache.

	Note: existing SqueakXR code (SRPlane, SRMorphPanel, etc.) accesses #internalMaterial directly, expecting it to be non-nil after #new. To keep that working when a GL context IS up, we still build eagerly. To stay safe at image-restart, check Raylib isWindowReady first."

	super initialize.
	Raylib isWindowReady ifTrue: [
		internalMaterial := Raylib loadMaterialDefault]
]

{ #category : #accessing }
SRMaterial >> internalMaterial [

	^ internalMaterial
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 5/28/2026 18:30'
}
SRMaterial >> internalMaterialFor: aSRRenderer [
	"Return the RlMaterial struct, building from scratch on cache miss. Each cache miss creates a fresh loadMaterialDefault and binds the SRTexture's current GPU texture."

	^ aSRRenderer cacheAt: self ifAbsentPut: [self buildInternalMaterialFor: aSRRenderer]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 3/11/2026 17:08'
}
SRMaterial >> shader: aShader [

	self unloadShader.
	shader := aShader.
	internalMaterial shader: shader internalShader.
]

{
	#category : #textures,
	#'squeak_changestamp' : 'MCPServer 5/28/2026 17:36'
}
SRMaterial >> srTexture [
	^ srTexture
]

{
	#category : #textures,
	#'squeak_changestamp' : 'MCPServer 5/28/2026 18:30'
}
SRMaterial >> srTexture: anSRTexture [
	"Store the SRTexture reference. We do NOT touch the GPU here -- that happens lazily in internalMaterialFor: when the renderer cache asks us to build."

	srTexture := anSRTexture.
	^ self
]

{ #category : #accessing }
SRMaterial >> texture [

	^ self internalMaterial maps texture
]

{ #category : #accessing }
SRMaterial >> texture: aRlTexture [

	internalMaterial maps texture: aRlTexture
]

{ #category : #'as yet unclassified' }
SRMaterial >> unloadInternalMaterial [

	self internalMaterial ifNotNil: [Raylib unloadMaterial: self internalMaterial]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 3/6/2026 16:48'
}
SRMaterial >> unloadShader [

	shader ifNotNil: [
		Raylib unloadShader: shader.
		shader := nil.]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 3/6/2026 16:47'
}
SRMaterial >> vertexShader: vertexShaderString fragmentShader: fragmentShaderString [

	self unloadShader.
	shader := Raylib loadShaderFromMemoryVsCode: vertexShaderString fsCode: fragmentShaderString.
	internalMaterial shader: shader.
]
