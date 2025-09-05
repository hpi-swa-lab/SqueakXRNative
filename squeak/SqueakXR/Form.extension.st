Extension { #name : #Form }

{ #category : #'*SqueakXR-core' }
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
		mipmaps: 4.
	Raylib genTextureMipmapsTexture: tex;
		setTextureFilterTexture: tex filter: RlTextureFilter textureFilterTrilinear.
	^ tex
]

{ #category : #'*SqueakXR-core' }
Form >> getTextureData [
	
	| data |
	self assert: (self width > 0 and: [self height > 0]) description: 'Form width and height must be greater than zero'.

	data := ExternalType byte allocate: self bitsSize * 4.
	data replaceFrom: 1 to: self bitsSize * 4 with: self bits asRGBAByteArray startingAt: 1.
	^ data
]

{ #category : #'*SqueakXR-core' }
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
