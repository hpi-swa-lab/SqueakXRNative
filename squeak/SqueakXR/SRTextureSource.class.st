"
A SRTextureSource provides a unified interface to texture data, abstracting away the underlying implementation.
"
Class {
	#name : #SRTextureSource,
	#superclass : #Object,
	#category : #'SqueakXR-Graphics-Texture',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer (leo) 10/14/2026 18:33'
}
SRTextureSource >> createInternalTexture [

	self subclassResponsibility.
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
	#'squeak_changestamp' : 'MCPServer (leo) 10/14/2026 18:33'
}
SRTextureSource >> onCacheInvalidated [

	self subclassResponsibility.
]
