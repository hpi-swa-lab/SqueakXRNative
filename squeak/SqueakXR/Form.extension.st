Extension { #name : #Form }

{
	#category : #'*SqueakXR-core',
	#'squeak_changestamp' : 'lege 2/23/2026 15:35'
}
Form >> createTexture [
	
	"Adapted from Raylib's LoadTextureFromImage"
	| tex |
	tex := RlTexture new
		id: (Raylib rlLoadTextureData: self getTextureData
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
	#'squeak_changestamp' : 'lege 2/18/2026 16:12'
}
Form >> getTextureData [
	
	| data |
	self assert: (self width > 0 and: [self height > 0]) description: 'Form width and height must be greater than zero'.

	data := ExternalType byte allocate: self bitsSize * 4.
	data replaceFrom: 1 to: self bitsSize * 4 with: self bits asRGBAByteArray startingAt: 1.
	^ data
]

{
	#category : #'*SqueakXR-core',
	#'squeak_changestamp' : 'lege 2/23/2026 15:35'
}
Form >> updateTexture: aTexture [
	
	"Adapted from Raylib's LoadTextureFromImage"
	Raylib rlUpdateTextureId: aTexture id
		offsetX: 0
		offsetY: 0
		width: self width
		height: self height
		format: RlPixelFormat pixelformatUncompressedR8g8b8a8
		data: self getTextureData;
		genTextureMipmapsTexture: aTexture
]

{
	#category : #'*SqueakXR-core',
	#'squeak_changestamp' : 'lege 2/23/2026 15:35'
}
Form >> updateTexture: aTexture in: aRectangle [
	
	"Adapted from Raylib's LoadTextureFromImage"
	Raylib rlUpdateTextureId: aTexture id
		offsetX: aRectangle left
		offsetY: aRectangle top
		width: aRectangle width
		height: aRectangle height
		format: RlPixelFormat pixelformatUncompressedR8g8b8a8
		data: self getTextureData;
		genTextureMipmapsTexture: aTexture
]
