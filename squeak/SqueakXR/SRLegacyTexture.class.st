"
An SRLegacyTexture owns a paired RlImage and RlTexture, with pixels persisted in a ByteArray so it survives image restart.
"
Class {
	#name : #SRLegacyTexture,
	#superclass : #Object,
	#instVars : [
		'image',
		'texture',
		'pixelBytes',
		'width',
		'height',
		'isUploaded'
	],
	#category : #'SqueakXR-Graphics-Texture',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'MCPServer 5/28/2026 17:35'
}
SRLegacyTexture class >> blank: aPoint [
	^ self solidColor: Color black extent: aPoint
]

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'MCPServer 5/28/2026 17:35'
}
SRLegacyTexture class >> checker: aChecksPoint color1: c1 color2: c2 extent: aPoint [
	| img t |
	img := Raylib
		genImageCheckedWidth: aPoint x
		height: aPoint y
		checksX: aChecksPoint x
		checksY: aChecksPoint y
		col1: c1 asRlColor
		col2: c2 asRlColor.
	t := self new initializeImage: img extent: aPoint.
	t snapshotImageToBytes.
	^ t
]

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'MCPServer 5/28/2026 17:35'
}
SRLegacyTexture class >> solidColor: aColor extent: aPoint [
	| img t |
	img := Raylib genImageColorWidth: aPoint x height: aPoint y color: aColor asRlColor.
	t := self new initializeImage: img extent: aPoint.
	t snapshotImageToBytes.
	^ t
]

{
	#category : #painting,
	#'squeak_changestamp' : 'MCPServer 6/8/2026 15:06'
}
SRLegacyTexture >> fillColor: aColor [

	self fillRect: (0 @ 0 extent: width @ height) color: aColor
]

{
	#category : #painting,
	#'squeak_changestamp' : 'MCPServer 6/8/2026 15:06'
}
SRLegacyTexture >> fillRect: aRectangle color: aColor [

	image ifNotNil: [
		Raylib
			imageDrawRectangleDst: image
			posX: aRectangle left
			posY: aRectangle top
			width: aRectangle width
			height: aRectangle height
			color: aColor asRlColor].
	aRectangle top to: aRectangle bottom - 1 do: [:y |
		aRectangle left to: aRectangle right - 1 do: [:x |
			self writePixelAt: x @ y color: aColor]]
]

{
	#category : #gpu,
	#'squeak_changestamp' : 'MCPServer 6/8/2026 15:06'
}
SRLegacyTexture >> flush [

	self currentRlTexture ifNil: [^ self].
	image ifNil: [^ self].
	texture ifNil: [^ self].
	Raylib updateTexture: texture pixels: image data.
	Raylib genTextureMipmapsTexture: texture
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 5/28/2026 17:36'
}
SRLegacyTexture >> height [
	^ height
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'MCPServer 6/8/2026 15:06'
}
SRLegacyTexture >> initializeImage: anRlImage extent: aPoint [

	image := anRlImage.
	width := aPoint x.
	height := aPoint y.
	isUploaded := false.
	^ self
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 6/8/2026 15:06'
}
SRLegacyTexture >> internalTexture [

	image ifNil: [self rebuildImageFromBytes].
	isUploaded ifFalse: [self upload].
	^ texture
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 5/28/2026 17:36'
}
SRLegacyTexture >> isUploaded [
	^ isUploaded ifNil: [false]
]

{
	#category : #lifecycle,
	#'squeak_changestamp' : 'MCPServer 6/8/2026 15:06'
}
SRLegacyTexture >> onCacheInvalidated [
]

{
	#category : #private,
	#'squeak_changestamp' : 'MCPServer 6/8/2026 15:06'
}
SRLegacyTexture >> rebuildImageFromBytes [

	| addr nBytes |
	pixelBytes ifNil: [^ self].
	image := Raylib genImageColorWidth: width height: height color: Color black asRlColor.
	addr := image data getHandle.
	nBytes := width * height * 4.
	1 to: nBytes do: [:i | addr byteAt: i put: (pixelBytes at: i)]
]

{
	#category : #painting,
	#'squeak_changestamp' : 'MCPServer 6/8/2026 15:06'
}
SRLegacyTexture >> setPixelAt: aPoint color: aColor [

	self writePixelAt: aPoint color: aColor.
	image ifNotNil: [
		Raylib imageDrawPixelDst: image posX: aPoint x posY: aPoint y color: aColor asRlColor]
]

{
	#category : #private,
	#'squeak_changestamp' : 'MCPServer 6/8/2026 15:06'
}
SRLegacyTexture >> snapshotImageToBytes [

	| addr nBytes |
	image ifNil: [^ self].
	addr := image data getHandle.
	nBytes := width * height * 4.
	pixelBytes := ByteArray new: nBytes.
	1 to: nBytes do: [:i | pixelBytes at: i put: (addr byteAt: i)]
]

{
	#category : #gpu,
	#'squeak_changestamp' : 'MCPServer 6/8/2026 15:06'
}
SRLegacyTexture >> upload [

	texture := Raylib loadTextureFromImage: image.
	Raylib genTextureMipmapsTexture: texture.
	Raylib setTextureFilterTexture: texture filter: RlTextureFilter textureFilterTrilinear.
	isUploaded := true
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 5/28/2026 17:36'
}
SRLegacyTexture >> width [
	^ width
]

{
	#category : #private,
	#'squeak_changestamp' : 'MCPServer 6/8/2026 15:06'
}
SRLegacyTexture >> writePixelAt: aPoint color: aColor [
	"RGBA, 4 bytes per pixel, row-major."

	| idx rgba |
	(aPoint x < 0 or: [aPoint x >= width or: [aPoint y < 0 or: [aPoint y >= height]]]) ifTrue: [^ self].
	idx := (aPoint y * width + aPoint x) * 4.
	rgba := aColor asRlColor.
	pixelBytes at: idx + 1 put: (rgba getHandle byteAt: 1).
	pixelBytes at: idx + 2 put: (rgba getHandle byteAt: 2).
	pixelBytes at: idx + 3 put: (rgba getHandle byteAt: 3).
	pixelBytes at: idx + 4 put: (rgba getHandle byteAt: 4)
]
