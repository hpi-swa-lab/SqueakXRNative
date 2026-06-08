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
	#'squeak_changestamp' : 'MCPServer 6/8/2026 15:07'
}
SRMaterial >> buildInternalMaterialFor: aSRRenderer [

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
	#'squeak_changestamp' : 'MCPServer 6/8/2026 15:07'
}
SRMaterial >> initialize [

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
	#'squeak_changestamp' : 'MCPServer 6/8/2026 15:07'
}
SRMaterial >> internalMaterialFor: aSRRenderer [

	^ aSRRenderer cacheAt: self ifAbsentPut: [self buildInternalMaterialFor: aSRRenderer]
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
	#'squeak_changestamp' : 'MCPServer 6/8/2026 15:07'
}
SRMaterial >> srTexture: anSRTexture [

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
