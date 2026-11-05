"
A SRTextureSource provides a unified interface to texture data, abstracting away the underlying implementation.
"
Class {
	#name : #SRTextureSource,
	#superclass : #Object,
	#instVars : [
		'internalTexture'
	],
	#category : #'SqueakXR-Graphics-Texture',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #'system startup',
	#'squeak_changestamp' : 'MCPServer (jl) 11/5/2026 11:38'
}
SRTextureSource class >> startUp: resuming [

	resuming ifFalse: [^ self].
	self allSubInstancesDo: [:each | each discardExternalObjects].
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer (leo) 10/14/2026 18:33'
}
SRTextureSource >> createInternalTexture [

	self subclassResponsibility.
]

{
	#category : #releasing,
	#'squeak_changestamp' : 'MCPServer (jl) 11/5/2026 11:52'
}
SRTextureSource >> discardExternalObjects [

	internalTexture := nil.
]

{
	#category : #updating,
	#'squeak_changestamp' : 'MCPServer (leo) 10/14/2026 18:33'
}
SRTextureSource >> notifyTextureChanged [

	self changed: #textureChanged.
]

{
	#category : #updating,
	#'squeak_changestamp' : 'MCPServer (jl) 11/5/2026 11:52'
}
SRTextureSource >> onCacheInvalidated [

	internalTexture := nil.
]

{
	#category : #updating,
	#'squeak_changestamp' : 'MCPServer (jl) 11/5/2026 11:52'
}
SRTextureSource >> unload [

	SRRenderer hasContext ifTrue: [
		internalTexture ifNotNil: [Raylib unloadTexture: internalTexture]].
	self discardExternalObjects.
]
