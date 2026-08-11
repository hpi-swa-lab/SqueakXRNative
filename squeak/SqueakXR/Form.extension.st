Extension { #name : #Form }

{
	#category : #'*SqueakXR-core',
	#'squeak_changestamp' : 'MCPServer 8/11/2026 15:48'
}
Form >> createTexture [
	
	"Adapted from Raylib's LoadTextureFromImage"
	| tex |
	SRRenderer ensureContext.
	tex := RlTexture new
		id: (Raylib rlLoadTextureData: self bits
			width: self width
			height: self height
			format: RlPixelFormat pixelformatUncompressedR8g8b8a8
			mipmapCount: 1);
		width: self width;
		height: self height;
		format: RlPixelFormat pixelformatUncompressedR8g8b8a8;
		mipmaps: 4 "self width log2 ceiling".
	Raylib genTextureMipmapsTexture: tex;
		setTextureFilterTexture: tex filter: RlTextureFilter textureFilterTrilinear.
	^ tex
]

{
	#category : #'*SqueakXR-core',
	#'squeak_changestamp' : 'MCPServer 8/11/2026 15:48'
}
Form >> updateTexture: aTexture in: aRectangle [
	
	"Adapted from Raylib's LoadTextureFromImage"
	SRRenderer ensureContext.
	Raylib rlUpdateTextureId: aTexture id
		offsetX: aRectangle left
		offsetY: aRectangle top
		width: aRectangle width
		height: aRectangle height
		format: RlPixelFormat pixelformatUncompressedR8g8b8a8
		data: self bits;
		genTextureMipmapsTexture: aTexture
]
