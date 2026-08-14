"
A thin GPU-handle cache over an SRTextureSource. Analog of SRMesh over SRMeshSource.

Holds a persistent RlTexture (rlTexture) built once from the source's pixelBytes via rlLoadTexture, mipmaps disabled. #syncToGpu pushes only the source's dirtyRect back to that same texture id with one rlUpdateTexture call -- no RlImage, no realloc, no loadTextureFromImage, no genTextureMipmaps -- so a per-frame update costs one FFI call over pinned bytes.

Unlike SRTexture this is not held in the renderer's per-frame cache and rebuilt on invalidation; the handle is long-lived and updated in place. SRMaterial reaches it through #internalTextureFor:, which just ensures the handle exists; the owner (e.g. SRGCStats) calls #syncToGpu each frame before drawing.

filter is point/nearest with a single mipmap level: for a small scrolling stats texture that keeps per-frame cost flat and avoids a full-texture mipmap pass on every update.
"
Class {
	#name : #SRFastTexture,
	#superclass : #Object,
	#instVars : [
		'source',
		'rlTexture'
	],
	#category : #'SqueakXR-Graphics-Texture',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'MCPServer 8/13/2026 13:36'
}
SRFastTexture class >> on: anSRTextureSource [

	^ self new source: anSRTextureSource
]

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'MCPServer 8/13/2026 13:36'
}
SRFastTexture class >> width: w height: h [

	^ self on: (SRTextureSource width: w height: h)
]

{
	#category : #gpu,
	#'squeak_changestamp' : 'MCPServer 8/13/2026 16:32'
}
SRFastTexture >> ensureGpu [
	"Build the persistent GPU texture once from the whole pixel buffer. Point
	filter, single mipmap level: cheap and flat per-frame, no mipmap pass."

	| bytes id |
	rlTexture ifNotNil: [^ rlTexture].
	SRRenderer assertContext.
	bytes := source bits.
	bytes pin.
	id := Raylib rlLoadTextureData: bytes
		width: source width
		height: source height
		format: RlPixelFormat pixelformatUncompressedR8g8b8a8
		mipmapCount: 1.
	rlTexture := RlTexture new
		id: id;
		width: source width;
		height: source height;
		format: RlPixelFormat pixelformatUncompressedR8g8b8a8;
		mipmaps: 1.
	Raylib setTextureFilterTexture: rlTexture filter: RlTextureFilter textureFilterPoint.
	source clearDirty.
	^ rlTexture
]

{
	#category : #gpu,
	#'squeak_changestamp' : 'MCPServer 8/13/2026 13:37'
}
SRFastTexture >> internalTextureFor: aSRRenderer [
	"The material caches its RlMaterial (and thus this handle) once. We keep the same
	handle alive and update it in place via #syncToGpu, so we ignore the renderer cache
	and just ensure the handle exists."

	^ self ensureGpu
]

{
	#category : #lifecycle,
	#'squeak_changestamp' : 'MCPServer 8/13/2026 13:37'
}
SRFastTexture >> onCacheInvalidated [
	"GL context went away (world stopped). Drop the handle; it rebuilds on next
	#ensureGpu, and the whole buffer will be re-marked dirty by the owner."

	rlTexture := nil
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 8/13/2026 13:36'
}
SRFastTexture >> rlTexture [

	^ rlTexture
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 8/13/2026 13:36'
}
SRFastTexture >> source [

	^ source
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 8/13/2026 13:36'
}
SRFastTexture >> source: anSRTextureSource [

	source := anSRTextureSource.
	source addDependent: self.
	^ self
]

{
	#category : #gpu,
	#'squeak_changestamp' : 'MCPServer 8/13/2026 16:32'
}
SRFastTexture >> syncToGpu [
	"If the source changed since the last sync, push the whole buffer to the existing
	texture id with one rlUpdateTexture over the pinned bytes -- zero allocation, no
	slice, no mipmap regen. Whole-buffer (offset 0) avoids pointer arithmetic on the
	ByteArray; at stats-texture sizes it is a few tens of KB per changed frame."

	| bytes |
	self ensureGpu.
	source dirtyRect ifNil: [^ rlTexture].
	bytes := source bits.
	bytes pin.
	Raylib
		rlUpdateTextureId: rlTexture id
		offsetX: 0
		offsetY: 0
		width: source width
		height: source height
		format: RlPixelFormat pixelformatUncompressedR8g8b8a8
		data: bytes.
	source clearDirty.
	^ rlTexture
]

{
	#category : #updating,
	#'squeak_changestamp' : 'MCPServer 8/13/2026 13:37'
}
SRFastTexture >> update: aSymbol [
	"Source change notification. The dirty region is already recorded on the source;
	#syncToGpu (driven by the owner each frame) does the upload."

	"nothing eager -- upload is pulled by syncToGpu"
]
