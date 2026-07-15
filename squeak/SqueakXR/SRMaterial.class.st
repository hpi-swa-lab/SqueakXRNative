Class {
	#name : #SRMaterial,
	#superclass : #Object,
	#instVars : [
		'internalMaterial',
		'shader',
		'texture'
	],
	#category : #'SqueakXR-Core'
}

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'SqueakXR 6/29/2026 16:43'
}
SRMaterial class >> withTexture: anSRTexture [
	^ self new texture: anSRTexture; yourself
]

{
	#category : #private,
	#'squeak_changestamp' : 'SqueakXR 6/29/2026 18:08'
}
SRMaterial >> buildInternalMaterialFor: aSRRenderer [

	internalMaterial := Raylib loadMaterialDefault.
	texture ifNotNil: [
		internalMaterial maps texture: (texture internalTextureFor: aSRRenderer)].
	shader ifNotNil: [
		internalMaterial shader: shader internalShader].
	^ internalMaterial
]

{
	#category : #initializing,
	#'squeak_changestamp' : 'lege 7/1/2026 15:57'
}
SRMaterial >> ensureInternalMaterial [

	^ internalMaterial ifNil: [internalMaterial := Raylib loadMaterialDefault]
]

{ #category : #'as yet unclassified' }
SRMaterial >> finalize [

	self unloadInternalMaterial
]

{
	#category : #initializing,
	#'squeak_changestamp' : 'lege 7/1/2026 15:57'
}
SRMaterial >> initialize [

	super initialize.
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
	#'squeak_changestamp' : 'SqueakXR 6/29/2026 16:41'
}
SRMaterial >> internalTexture [

	self flag: #remove.
	^ self internalMaterial maps texture
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 7/13/2026 19:14'
}
SRMaterial >> internalTexture: aRlTexture [

	self flag: #remove.
	self ensureInternalMaterial maps texture: aRlTexture
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
	#'squeak_changestamp' : 'lege 7/1/2026 15:59'
}
SRMaterial >> shader: aShader [

	self unloadShader.
	shader := aShader.
	self ensureInternalMaterial shader: shader internalShader.
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
	#'squeak_changestamp' : 'SqueakXR 6/29/2026 16:42'
}
SRMaterial >> texture: anSRTexture [

	texture := anSRTexture.
	^ self
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
