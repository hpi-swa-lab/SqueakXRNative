"
An SRTexture owns a paired RlImage (CPU pixels) and RlTexture (GPU handle). The canonical CPU storage lives in an image-persistent ByteArray (pixelBytes) so the texture survives image save/restart.

Data flow mirrors SRMesh:
  pixelBytes (ByteArray, image-persistent)
    |
    v   (lazy materialize on first GPU access)
  RlImage (off-heap pixels) -> RlTexture (GPU handle)

For dynamic textures, mutations via setPixelAt:color: etc. write to the RlImage. shutDown: copies the latest pixels into pixelBytes; startUp: drops external handles so the next render rebuilds.

Set #beTransient if you don't want painted state to persist (texture will be rebuilt from its construction recipe -- factory selector + args).

ivars:
  image        RlImage (transient -- pointer dies on restart)
  texture      RlTexture (transient -- GL handle dies on restart)
  pixelBytes   ByteArray of RGBA bytes (image-persistent canonical store)
  width, height
  isUploaded   transient
  isTransient  if true, on restart we drop pixelBytes and rebuild via recipe instead of restoring
"
Class {
	#name : #SRTexture,
	#superclass : #Object,
	#instVars : [
		'image',
		'texture',
		'pixelBytes',
		'width',
		'height',
		'isUploaded'
	],
	#category : #'SqueakXR-Core',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'MCPServer 5/28/2026 17:35'
}
SRTexture class >> blank: aPoint [
	^ self solidColor: Color black extent: aPoint
]

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'MCPServer 5/28/2026 17:35'
}
SRTexture class >> checker: aChecksPoint color1: c1 color2: c2 extent: aPoint [
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
SRTexture class >> solidColor: aColor extent: aPoint [
	| img t |
	img := Raylib genImageColorWidth: aPoint x height: aPoint y color: aColor asRlColor.
	t := self new initializeImage: img extent: aPoint.
	t snapshotImageToBytes.
	^ t
]

{
	#category : #private,
	#'squeak_changestamp' : 'MCPServer 5/28/2026 18:30'
}
SRTexture >> buildAndUploadRlTexture [
	"Materialize an RlImage from canonical pixelBytes, upload to a fresh RlTexture handle. Returns the texture."

	| addr nBytes |
	image := Raylib genImageColorWidth: width height: height color: Color black asRlColor.
	addr := image data getHandle.
	nBytes := width * height * 4.
	1 to: nBytes do: [:i | addr byteAt: i put: (pixelBytes at: i)].
	texture := Raylib loadTextureFromImage: image.
	Raylib genTextureMipmapsTexture: texture.
	Raylib setTextureFilterTexture: texture filter: RlTextureFilter textureFilterTrilinear.
	isUploaded := true.
	^ texture
]

{
	#category : #painting,
	#'squeak_changestamp' : 'MCPServer 5/28/2026 17:45'
}
SRTexture >> fillColor: aColor [
	"Clear the whole image and pixelBytes to a solid color."

	self fillRect: (0 @ 0 extent: width @ height) color: aColor
]

{
	#category : #painting,
	#'squeak_changestamp' : 'MCPServer 5/28/2026 18:31'
}
SRTexture >> fillRect: aRectangle color: aColor [
	"Fill a rectangle in pixelBytes; also in the RlImage if it exists."

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
	#'squeak_changestamp' : 'MCPServer 5/29/2026 10:38'
}
SRTexture >> flush [
	"Push the current CPU pixels to the existing GPU texture handle. Calls currentRlTexture first to ensure the local image/texture ivars are populated for the current session (rebuilds via cache miss after image restart)."

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
SRTexture >> height [
	^ height
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'MCPServer 5/28/2026 17:44'
}
SRTexture >> initializeImage: anRlImage extent: aPoint [
	image := anRlImage.
	width := aPoint x.
	height := aPoint y.
	isUploaded := false.
	^ self
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 5/28/2026 17:36'
}
SRTexture >> internalTexture [
	"Lazily rebuild RlImage from pixelBytes and upload to a fresh RlTexture handle. Used by SRMaterial to bind the diffuse map."

	image ifNil: [self rebuildImageFromBytes].
	isUploaded ifFalse: [self upload].
	^ texture
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 5/28/2026 18:30'
}
SRTexture >> internalTextureFor: aSRRenderer [
	"Return the GPU RlTexture handle, building and uploading on first access via the renderer cache. All GL work gated by this call, which only happens at render time."

	^ aSRRenderer cacheAt: self ifAbsentPut: [self buildAndUploadRlTexture]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 5/28/2026 17:36'
}
SRTexture >> isUploaded [
	^ isUploaded ifNil: [false]
]

{
	#category : #lifecycle,
	#'squeak_changestamp' : 'MCPServer 5/28/2026 18:29'
}
SRTexture >> onCacheInvalidated [
	"Renderer cache is being cleared. Our RlImage + RlTexture live in the cache. Do nothing here; cache miss on next render will rebuild from pixelBytes."
]

{
	#category : #private,
	#'squeak_changestamp' : 'MCPServer 5/28/2026 17:37'
}
SRTexture >> rebuildImageFromBytes [
	"Allocate a fresh RlImage of the right extent and copy pixelBytes into its data buffer."

	| addr nBytes |
	pixelBytes ifNil: [^ self].
	image := Raylib genImageColorWidth: width height: height color: Color black asRlColor.
	addr := image data getHandle.
	nBytes := width * height * 4.
	1 to: nBytes do: [:i | addr byteAt: i put: (pixelBytes at: i)]
]

{
	#category : #painting,
	#'squeak_changestamp' : 'MCPServer 5/28/2026 18:31'
}
SRTexture >> setPixelAt: aPoint color: aColor [
	"Set a pixel in pixelBytes (canonical) and in the RlImage (if it exists -- so subsequent flush is cheap). If image is nil we are pre-upload; canonical bytes hold the truth and the first render will pick them up."

	self writePixelAt: aPoint color: aColor.
	image ifNotNil: [
		Raylib imageDrawPixelDst: image posX: aPoint x posY: aPoint y color: aColor asRlColor]
]

{
	#category : #private,
	#'squeak_changestamp' : 'MCPServer 5/28/2026 17:37'
}
SRTexture >> snapshotImageToBytes [
	"Copy the current RlImage's pixel data into the canonical ByteArray. RlImage pixels are RGBA bytes (4 per pixel)."

	| addr nBytes |
	image ifNil: [^ self].
	addr := image data getHandle.
	nBytes := width * height * 4.
	pixelBytes := ByteArray new: nBytes.
	1 to: nBytes do: [:i | pixelBytes at: i put: (addr byteAt: i)]
]

{
	#category : #gpu,
	#'squeak_changestamp' : 'MCPServer 5/28/2026 17:36'
}
SRTexture >> upload [
	"Upload the current RlImage to a fresh GPU texture handle."

	texture := Raylib loadTextureFromImage: image.
	Raylib genTextureMipmapsTexture: texture.
	Raylib setTextureFilterTexture: texture filter: RlTextureFilter textureFilterTrilinear.
	isUploaded := true
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 5/28/2026 17:36'
}
SRTexture >> width [
	^ width
]

{
	#category : #private,
	#'squeak_changestamp' : 'MCPServer 5/28/2026 17:44'
}
SRTexture >> writePixelAt: aPoint color: aColor [
	"Mirror a single pixel write into the canonical pixelBytes ByteArray. RGBA byte layout, 4 bytes per pixel, row-major."

	| idx rgba |
	(aPoint x < 0 or: [aPoint x >= width or: [aPoint y < 0 or: [aPoint y >= height]]]) ifTrue: [^ self].
	idx := (aPoint y * width + aPoint x) * 4.
	rgba := aColor asRlColor.
	pixelBytes at: idx + 1 put: (rgba getHandle byteAt: 1).
	pixelBytes at: idx + 2 put: (rgba getHandle byteAt: 2).
	pixelBytes at: idx + 3 put: (rgba getHandle byteAt: 3).
	pixelBytes at: idx + 4 put: (rgba getHandle byteAt: 4)
]
