Class {
	#name : #SRMaterial,
	#superclass : #Object,
	#instVars : [
		'internalMaterial',
		'shader',
		'texture',
		'isDirty'
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
	#category : #private,
	#'squeak_changestamp' : 'MCPServer (leo) 10/15/2026 15:19'
}
SRMaterial >> buildInternalMaterialFor: aSRRenderer [

	internalMaterial := Raylib loadMaterialDefault.
	shader ifNotNil: [
		internalMaterial shader: shader internalShader].
	^ internalMaterial
]

{ #category : #'as yet unclassified' }
SRMaterial >> finalize [

	self unloadInternalMaterial
]

{
	#category : #initializing,
	#'squeak_changestamp' : 'lege 7/16/2026 15:46'
}
SRMaterial >> initialize [

	isDirty := true.
]

{ #category : #accessing }
SRMaterial >> internalMaterial [

	^ internalMaterial
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer (leo) 10/14/2026 18:23'
}
SRMaterial >> internalMaterialFor: aSRRenderer [

	| material |
	isDirty ifTrue: [
		aSRRenderer removeAt: self.
		isDirty := false].
	material := aSRRenderer cacheAt: self ifAbsentPut: [self buildInternalMaterialFor: aSRRenderer].
	texture ifNotNil: [material maps texture: texture internalTexture].
	^ material
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer (leo) 10/15/2026 15:19'
}
SRMaterial >> onCacheInvalidated [

	internalMaterial := nil.
	shader ifNotNil: [shader onCacheInvalidated].
	texture ifNotNil: [texture onCacheInvalidated].
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
	#'squeak_changestamp' : 'MCPServer 9/21/2026 16:15'
}
SRMaterial >> texture: anSRTexture [

	texture := anSRTexture.
	isDirty := true.
	^ self
]

{ #category : #'as yet unclassified' }
SRMaterial >> unloadInternalMaterial [

	self internalMaterial ifNotNil: [Raylib unloadMaterial: self internalMaterial]
]
