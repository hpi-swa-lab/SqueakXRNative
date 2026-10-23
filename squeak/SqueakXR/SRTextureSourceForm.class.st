"
A texture source backed by a 32-bit Form. Squeak Forms are BGRA, so draw with the morphicPanel shader.
"
Class {
	#name : #SRTextureSourceForm,
	#superclass : #SRTextureSource,
	#instVars : [
		'form',
		'canvas',
		'width',
		'height',
		'internalTexture',
		'isEditable'
	],
	#category : #'SqueakXR-Graphics-Texture',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'MCPServer 8/13/2026 13:35'
}
SRTextureSourceForm class >> width: w height: h [

	^ self new setWidth: w height: h
]

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'MCPServer (leo) 10/14/2026 18:30'
}
SRTextureSourceForm class >> width: w height: h fill: aColor [

	^ (self width: w height: h) editDo: [:source | source fillColor: aColor]; yourself
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer (MCPServer (MCPServer)) 10/23/2026 11:01'
}
SRTextureSourceForm >> bits [

	form unhibernate ifTrue: [self notifyTextureChanged].
	^ form bits
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer (leo) 10/14/2026 18:27'
}
SRTextureSourceForm >> createInternalTexture [

	SRRenderer assertContext.
	internalTexture
		ifNil: [self loadInternalTexture]
		ifNotNil: [self updateInternalTexture].
	^ internalTexture
]

{
	#category : #editing,
	#'squeak_changestamp' : 'MCPServer (leo) 10/14/2026 18:33'
}
SRTextureSourceForm >> drawForm: aForm at: aPoint [

	self drawForm: aForm at: aPoint extent: aForm width @ aForm height.
]

{
	#category : #editing,
	#'squeak_changestamp' : 'MCPServer (leo) 10/14/2026 18:33'
}
SRTextureSourceForm >> drawForm: aForm at: aPoint extent: anExtent [

	self assert: isEditable.
	form
		copy: (0 @ 0 extent: (anExtent x min: aForm width) @ (anExtent y min: aForm height))
		from: aForm
		to: aPoint
		rule: Form over.
]

{
	#category : #editing,
	#'squeak_changestamp' : 'MCPServer (leo) 10/14/2026 18:33'
}
SRTextureSourceForm >> drawString: aString at: aPoint color: aColor on: bgColor font: aFont [

	self assert: isEditable.
	canvas
		fillRectangle: (aPoint extent: ((aFont widthOfString: aString) max: 1) @ aFont height)
		color: bgColor.
	canvas drawString: aString at: aPoint font: aFont color: aColor.
]

{
	#category : #editing,
	#'squeak_changestamp' : 'MCPServer (leo) 10/14/2026 18:33'
}
SRTextureSourceForm >> editDo: aBlock [

	isEditable := true.
	[aBlock cull: self] ensure: [isEditable := false].
	self notifyTextureChanged.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 8/13/2026 13:35'
}
SRTextureSourceForm >> extent [

	^ width @ height
]

{
	#category : #editing,
	#'squeak_changestamp' : 'MCPServer (leo) 10/14/2026 18:33'
}
SRTextureSourceForm >> fillColor: aColor [

	self fillRect: (0 @ 0 corner: width @ height) color: aColor.
]

{
	#category : #editing,
	#'squeak_changestamp' : 'MCPServer (leo) 10/14/2026 18:33'
}
SRTextureSourceForm >> fillRect: aRectangle color: aColor [

	self assert: isEditable.
	canvas fillRectangle: (aRectangle intersect: (0 @ 0 corner: width @ height)) truncated color: aColor.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 8/13/2026 16:30'
}
SRTextureSourceForm >> form [

	^ form
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 8/13/2026 13:35'
}
SRTextureSourceForm >> height [

	^ height
]

{
	#category : #private,
	#'squeak_changestamp' : 'MCPServer (leo) 10/14/2026 18:33'
}
SRTextureSourceForm >> loadInternalTexture [

	internalTexture := RlTexture new
		id: (Raylib
			rlLoadTextureData: (self bits pin; yourself)
			width: width
			height: height
			format: RlPixelFormat pixelformatUncompressedR8g8b8a8
			mipmapCount: 1);
		width: width;
		height: height;
		format: RlPixelFormat pixelformatUncompressedR8g8b8a8;
		mipmaps: 1.
	Raylib setTextureFilterTexture: internalTexture filter: RlTextureFilter textureFilterBilinear.
]

{
	#category : #updating,
	#'squeak_changestamp' : 'MCPServer (leo) 10/14/2026 18:33'
}
SRTextureSourceForm >> onCacheInvalidated [

	internalTexture := nil.
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'MCPServer (leo) 10/14/2026 18:33'
}
SRTextureSourceForm >> setWidth: w height: h [

	width := w.
	height := h.
	form := Form extent: w @ h depth: 32.
	canvas := form getCanvas.
	isEditable := false.
]

{
	#category : #private,
	#'squeak_changestamp' : 'MCPServer (leo) 10/14/2026 18:33'
}
SRTextureSourceForm >> updateInternalTexture [

	Raylib
		rlUpdateTextureId: internalTexture id
		offsetX: 0
		offsetY: 0
		width: width
		height: height
		format: RlPixelFormat pixelformatUncompressedR8g8b8a8
		data: (self bits pin; yourself).
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 8/13/2026 13:35'
}
SRTextureSourceForm >> width [

	^ width
]
