Extension { #name : #Form }

{ #category : #'*SqueakXR-core' }
Form >> createTexture [
	
	| data |
	self assert: (self width > 0 and: [self height > 0]) description: 'Form width and height must be greater than zero'.

	
	data := ExternalType byte allocate: self bitsSize * 4.
	data replaceFrom: 1 to: self bitsSize * 4 with: self bits asRGBAByteArray startingAt: 1.

	"Adapted from Raylib's LoadTextureFromImage"
	^ RlTexture new
		id: (Raylib rlLoadTextureData: data
			width: self width
			height: self height
			format: RlPixelFormat pixelformatUncompressedR8g8b8a8
			mipmapCount: 1);
		width: self width;
		height: self height;
		format: RlPixelFormat pixelformatUncompressedR8g8b8a8;
		mipmaps: 1
]
