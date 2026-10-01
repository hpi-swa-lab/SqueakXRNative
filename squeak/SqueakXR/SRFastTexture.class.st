"
A long-lived GPU handle over an SRTextureSource, the analog of SRMesh over SRMeshSource.

Unlike SRTexture it is not held in the renderer's per-frame cache and rebuilt on
invalidation. The RlTexture is built once and updated in place, so a per-frame
update is one rlUpdateTexture over the source's pinned bytes: no RlImage, no
reallocation, no mipmap pass. SRMaterial reaches the handle through
#internalTextureFor:; the owner (e.g. SRGCStats) calls #syncToGpu each frame
before drawing.
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
	#'squeak_changestamp' : 'MCPServer 9/21/2026 16:15'
}
SRFastTexture >> ensureGpu [
	"One mipmap level, so an update costs no mipmap regeneration pass."

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
	Raylib setTextureFilterTexture: rlTexture filter: RlTextureFilter textureFilterBilinear.
	source clearDirty.
	^ rlTexture
]

{
	#category : #gpu,
	#'squeak_changestamp' : 'MCPServer 9/21/2026 16:17'
}
SRFastTexture >> internalTextureFor: aSRRenderer [
	"The renderer's per-frame cache is deliberately ignored: SRMaterial caches the
	RlMaterial and thus this handle once, and the handle stays valid because
	#syncToGpu updates it in place."

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
	#'squeak_changestamp' : 'MCPServer 9/21/2026 16:17'
}
SRFastTexture >> syncToGpu [
	"Uploads the whole buffer rather than the dirty rows: a slice would need pointer
	arithmetic on the ByteArray, and at stats-texture sizes the whole thing is a few
	tens of KB."

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
	#'squeak_changestamp' : 'MCPServer 9/21/2026 16:15'
}
SRFastTexture >> update: aSymbol [
	"Nothing eager: the source has already recorded the dirty region, and the owner
	pulls the upload with #syncToGpu once per frame."
]
