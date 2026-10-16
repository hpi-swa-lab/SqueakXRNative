"
A texture source backed by a raylib RlImage.
"
Class {
	#name : #SRTextureSourceImage,
	#superclass : #SRTextureSource,
	#instVars : [
		'image',
		'internalTexture',
		'isEditable',
		'width',
		'height'
	],
	#category : #'SqueakXR-Graphics-Texture',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #'class initialization',
	#'squeak_changestamp' : 'MCPServer (leo) 10/15/2026 16:06'
}
SRTextureSourceImage class >> initialize [

	Smalltalk addToStartUpList: self before: SRWorld.
]

{
	#category : #'system startup',
	#'squeak_changestamp' : 'MCPServer (leo) 10/15/2026 16:06'
}
SRTextureSourceImage class >> startUp: resuming [

	resuming ifFalse: [^ self].
	self allInstancesDo: [:each | each discardExternalObjects].
]

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'MCPServer (leo) 10/15/2026 11:10'
}
SRTextureSourceImage class >> width: w height: h [

	^ self new setWidth: w height: h; yourself
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer (leo) 10/15/2026 15:53'
}
SRTextureSourceImage >> createInternalTexture [

	SRRenderer assertContext.
	internalTexture
		ifNil: [internalTexture := Raylib loadTextureFromImage: self image]
		ifNotNil: [Raylib updateTexture: internalTexture pixels: self image data].
	^ internalTexture
]

{
	#category : #releasing,
	#'squeak_changestamp' : 'MCPServer (leo) 10/15/2026 15:53'
}
SRTextureSourceImage >> discardExternalObjects [

	image := nil.
	internalTexture := nil.
]

{
	#category : #drawing,
	#'squeak_changestamp' : 'MCPServer (leo) 10/15/2026 15:53'
}
SRTextureSourceImage >> drawLineFrom: startPoint to: endPoint color: aColor [

	self assert: isEditable.
	Raylib imageDrawLineDst: self image
		startPosX: startPoint x startPosY: startPoint y
		endPosX: endPoint x endPosY: endPoint y
		color: aColor asRlColor.
]

{
	#category : #updating,
	#'squeak_changestamp' : 'MCPServer (leo) 10/15/2026 11:10'
}
SRTextureSourceImage >> editDo: aBlock [

	isEditable := true.
	[aBlock cull: self] ensure: [isEditable := false].
	self notifyTextureChanged.
]

{
	#category : #drawing,
	#'squeak_changestamp' : 'MCPServer (leo) 10/15/2026 15:53'
}
SRTextureSourceImage >> fillColor: aColor [

	self assert: isEditable.
	Raylib imageClearBackgroundDst: self image color: aColor asRlColor.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer (leo) 10/15/2026 15:53'
}
SRTextureSourceImage >> height [

	^ height
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer (leo) 10/15/2026 15:53'
}
SRTextureSourceImage >> image [

	^ image ifNil: [image := Raylib genImageColorWidth: width height: height color: Color black asRlColor]
]

{
	#category : #updating,
	#'squeak_changestamp' : 'MCPServer (leo) 10/15/2026 11:10'
}
SRTextureSourceImage >> onCacheInvalidated [

	internalTexture := nil.
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'MCPServer (leo) 10/15/2026 15:53'
}
SRTextureSourceImage >> setWidth: w height: h [

	width := w.
	height := h.
	isEditable := false.
]

{
	#category : #releasing,
	#'squeak_changestamp' : 'MCPServer (leo) 10/15/2026 15:53'
}
SRTextureSourceImage >> unload [

	SRRenderer hasContext ifTrue: [
		internalTexture ifNotNil: [Raylib unloadTexture: internalTexture]].
	internalTexture := nil.
	image ifNotNil: [Raylib unloadImage: image].
	image := nil.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer (leo) 10/15/2026 15:53'
}
SRTextureSourceImage >> width [

	^ width
]
