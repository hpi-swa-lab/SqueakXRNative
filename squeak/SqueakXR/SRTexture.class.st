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
	#category : #'instance creation',
	#'squeak_changestamp' : 'MCPServer (leo) 10/14/2026 18:22'
}
SRTexture class >> withSource: aTextureSource [

	^ self new source: aTextureSource
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
	#'squeak_changestamp' : 'MCPServer (leo) 10/14/2026 18:33'
}
SRTexture >> source: aTextureSource [

	source ifNotNil: [source removeDependent: self].
	source := aTextureSource.
	source addDependent: self.
	internalTexture := nil.
]

{
	#category : #updating,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/23/2026 12:28'
}
SRTexture >> unload [

	source unload.
	internalTexture := nil.
]

{
	#category : #updating,
	#'squeak_changestamp' : 'MCPServer (leo) 10/14/2026 18:33'
}
SRTexture >> update: aSymbol [

	aSymbol = #textureChanged ifTrue: [
		internalTexture := nil].
]
