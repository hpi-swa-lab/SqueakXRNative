"
An SRTexture holds texture data.
"
Class {
	#name : #SRTexture,
	#superclass : #Object,
	#instVars : [
		'internalTexture',
		'source'
	],
	#category : #'SqueakXR-Graphics-Texture',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #'system startup',
	#'squeak_changestamp' : 'MCPServer (jl) 11/5/2026 11:38'
}
SRTexture class >> startUp: resuming [

	resuming ifFalse: [^ self].
	self allInstancesDo: [:each | each discardExternalObjects].
]

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'MCPServer (leo) 10/14/2026 18:22'
}
SRTexture class >> withSource: aTextureSource [

	^ self new source: aTextureSource
]

{
	#category : #releasing,
	#'squeak_changestamp' : 'MCPServer (jl) 11/5/2026 11:38'
}
SRTexture >> discardExternalObjects [

	internalTexture := nil.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer (leo) 10/14/2026 18:22'
}
SRTexture >> internalTexture [

	^ internalTexture ifNil: [internalTexture := self source createInternalTexture]
]

{
	#category : #updating,
	#'squeak_changestamp' : 'MCPServer (leo) 10/14/2026 18:33'
}
SRTexture >> onCacheInvalidated [

	internalTexture := nil.
	source ifNotNil: [source onCacheInvalidated].
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 8/13/2026 13:36'
}
SRTexture >> source [

	^ source
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer (leo) 10/30/2026 16:33'
}
SRTexture >> source: aTextureSource [

	source ifNotNil: [source removeDependent: self].
	source := aTextureSource.
	source addDependent: self.
	internalTexture := nil.
	self changed: #textureChanged.
]

{
	#category : #updating,
	#'squeak_changestamp' : 'MCPServer (jl) 11/5/2026 11:52'
}
SRTexture >> unload [

	source unload.
	self discardExternalObjects.
]

{
	#category : #updating,
	#'squeak_changestamp' : 'MCPServer (leo) 10/30/2026 15:55'
}
SRTexture >> update: aSymbol [

	aSymbol = #textureChanged ifTrue: [
		internalTexture := nil.
		self changed: #textureChanged].
]
