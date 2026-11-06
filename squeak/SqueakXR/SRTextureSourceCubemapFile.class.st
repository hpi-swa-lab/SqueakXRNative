"
A cubemap loaded from an image file in a layout raylib can auto-detect.
"
Class {
	#name : #SRTextureSourceCubemapFile,
	#superclass : #SRTextureSourceFile,
	#category : #'SqueakXR-Graphics-Texture',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #private,
	#'squeak_changestamp' : 'MCPServer (leo) 10/30/2026 16:33'
}
SRTextureSourceCubemapFile >> loadInternalTexture [

	| image |
	image := Raylib loadImageFileName: path.
	^ [Raylib loadTextureCubemapImage: image layout: RlCubemapLayout cubemapLayoutAutoDetect]
		ensure: [Raylib unloadImage: image]
]
