Class {
	#name : #SRMaterial,
	#superclass : #Object,
	#instVars : [
		'internalMaterial',
		'shader'
	],
	#category : #'SqueakXR-Core'
}

{ #category : #'as yet unclassified' }
SRMaterial >> finalize [

	self unloadInternalMaterial
]

{ #category : #initializing }
SRMaterial >> initialize [ 

	super initialize.
	
	internalMaterial := Raylib loadMaterialDefault.
]

{ #category : #accessing }
SRMaterial >> internalMaterial [

	^ internalMaterial
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
