"
Form-backed CPU pixel store for a texture, the analog of SRMeshSourceRaw. Owns a
long-lived 32-bit Form that callers mutate in place through BitBlt, and
accumulates a dirtyRect across those edits so SRFastTexture can upload once.

Squeak 32bpp Forms are BGRA premultiplied, which is the byte order raylib reads
as R8G8B8A8, so the quad must draw with the morphicPanel shader that swizzles
.bgra on the GPU. Same contract as SRMorphTexture.
"
Class {
	#name : #SRTextureSource,
	#superclass : #Object,
	#instVars : [
		'form',
		'canvas',
		'width',
		'height',
		'dirtyRect'
	],
	#category : #'SqueakXR-Graphics-Texture',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'MCPServer 8/13/2026 13:35'
}
SRTextureSource class >> width: w height: h [

	^ self new setWidth: w height: h
]

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'MCPServer 8/13/2026 13:35'
}
SRTextureSource class >> width: w height: h fill: aColor [

	^ (self width: w height: h) fillColor: aColor; yourself
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 9/21/2026 16:17'
}
SRTextureSource >> bits [
	"BGRA byte order, see the class comment."

	^ form bits
]

{
	#category : #'dirty tracking',
	#'squeak_changestamp' : 'MCPServer 9/21/2026 16:17'
}
SRTextureSource >> clearDirty [
	dirtyRect := nil
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 8/13/2026 13:35'
}
SRTextureSource >> dirtyRect [
	"nil means clean; otherwise the bounding box of pixels changed since the last clear."

	^ dirtyRect
]

{
	#category : #editing,
	#'squeak_changestamp' : 'MCPServer 9/21/2026 16:16'
}
SRTextureSource >> drawForm: aForm at: aPoint [
	self drawForm: aForm at: aPoint extent: aForm width @ aForm height
]

{
	#category : #editing,
	#'squeak_changestamp' : 'MCPServer 9/21/2026 16:16'
}
SRTextureSource >> drawForm: aForm at: aPoint extent: anExtent [
	"Replaces the destination rather than compositing over it, so a Form with
	transparent pixels puts them through as transparent."

	| w h |
	w := anExtent x min: aForm width.
	h := anExtent y min: aForm height.
	form
		copy: (0 @ 0 extent: w @ h)
		from: aForm
		to: aPoint
		rule: Form over.
	self markDirty: (aPoint extent: w @ h)
]

{
	#category : #editing,
	#'squeak_changestamp' : 'MCPServer 8/13/2026 16:31'
}
SRTextureSource >> drawString: aString at: aPoint color: aColor on: bgColor font: aFont [
	"As #drawString:at:color:on: but with an explicit font. A StrikeFont (bitmap) gives
	1-bit glyphs that stay crisp under point-filtering in 3D; a TTCFont matches the
	desktop GC Stats baseline."

	| w h |
	w := (aFont widthOfString: aString) max: 1.
	h := aFont height.
	"Draw straight onto the backing Form over a fresh bg fill, so BitBlt antialiases
	the glyphs against the real background. One fill + one string blit, in C."
	canvas fillRectangle: (aPoint extent: w @ h) color: bgColor.
	canvas drawString: aString at: aPoint font: aFont color: aColor.
	self markDirty: (aPoint extent: w @ h)
]

{
	#category : #editing,
	#'squeak_changestamp' : 'MCPServer 9/21/2026 16:17'
}
SRTextureSource >> editDo: aBlock [
	"Dependents are notified once for the whole block, not once per edit."

	aBlock cull: self.
	self notifyTextureChanged
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 8/13/2026 13:35'
}
SRTextureSource >> extent [

	^ width @ height
]

{
	#category : #editing,
	#'squeak_changestamp' : 'MCPServer 8/13/2026 13:36'
}
SRTextureSource >> fillColor: aColor [

	self fillRect: (0 @ 0 corner: width @ height) color: aColor
]

{
	#category : #editing,
	#'squeak_changestamp' : 'MCPServer 8/13/2026 16:30'
}
SRTextureSource >> fillRect: aRectangle color: aColor [

	| clamped |
	clamped := (aRectangle intersect: (0 @ 0 corner: width @ height)) truncated.
	(clamped width <= 0 or: [clamped height <= 0]) ifTrue: [^ self].
	canvas fillRectangle: clamped color: aColor.
	self markDirty: clamped
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 8/13/2026 16:30'
}
SRTextureSource >> form [

	^ form
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 8/13/2026 13:35'
}
SRTextureSource >> height [

	^ height
]

{
	#category : #'dirty tracking',
	#'squeak_changestamp' : 'MCPServer 8/13/2026 13:35'
}
SRTextureSource >> markAllDirty [

	self markDirty: (0 @ 0 corner: width @ height)
]

{
	#category : #'dirty tracking',
	#'squeak_changestamp' : 'MCPServer 9/21/2026 16:17'
}
SRTextureSource >> markDirty: aRectangle [
	| clamped |
	clamped := aRectangle intersect: (0 @ 0 corner: width @ height).
	(clamped width <= 0 or: [clamped height <= 0]) ifTrue: [^ self].
	dirtyRect := dirtyRect
		ifNil: [clamped]
		ifNotNil: [dirtyRect merge: clamped]
]

{
	#category : #'dirty tracking',
	#'squeak_changestamp' : 'MCPServer 8/13/2026 13:35'
}
SRTextureSource >> notifyTextureChanged [

	self changed: #textureChanged
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'MCPServer 8/13/2026 16:30'
}
SRTextureSource >> setWidth: w height: h [

	width := w.
	height := h.
	form := Form extent: w @ h depth: 32.
	canvas := form getCanvas.
	dirtyRect := nil.
	^ self
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 8/13/2026 13:35'
}
SRTextureSource >> width [

	^ width
]
