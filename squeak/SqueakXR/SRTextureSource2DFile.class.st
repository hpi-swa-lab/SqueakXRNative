"
A 2D texture loaded from an image file.
"
Class {
	#name : #SRTextureSource2DFile,
	#superclass : #SRTextureSourceFile,
	#category : #'SqueakXR-Graphics-Texture',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #private,
	#'squeak_changestamp' : 'MCPServer (leo) 10/30/2026 16:33'
}
SRTextureSource2DFile >> loadInternalTexture [

	^ Raylib loadTextureFileName: path
]
