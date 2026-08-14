"
Form-backed CPU pixel store for a texture. Analog of SRMeshSourceRaw: owns a long-lived 32-bit Form (form) that callers mutate in place through BitBlt (fillRect:, drawForm:, drawString:, scrollLeftBy:), plus a dirtyRect accumulated across those edits. SRFastTexture uploads the Form's bits with one rlUpdateTexture over the dirty rows -- no per-pixel Smalltalk loop, no RlImage, no reallocation.

Squeak 32bpp Forms are BGRA (premultiplied) in the byte order raylib reads as R8G8B8A8, so the quad must draw with the morphicPanel shader (which swizzles .bgra on the GPU). This is the same contract SRMorphTexture uses. The whole point is a per-frame update whose cost is a few BitBlts plus one upload, so it can drive SRGCStats without perturbing what it measures.
"
Class {
	#name : #SRTextureSource,
	#superclass : #Object,
	#instVars : [
		'form',
		'canvas',
		'width',
		'height',
		'dirtyRect',
		'textForm'
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
	#'squeak_changestamp' : 'MCPServer 8/13/2026 16:30'
}
SRTextureSource >> bits [
	"The raw Bitmap uploaded to the GPU. BGRA byte order (see class comment)."

	^ form bits
]

{
	#category : #'dirty tracking',
	#'squeak_changestamp' : 'MCPServer 8/13/2026 13:35'
}
SRTextureSource >> clearDirty [
	"Cleared by the cache after it has uploaded the dirty region."

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
	#'squeak_changestamp' : 'MCPServer 8/13/2026 15:19'
}
SRTextureSource >> drawForm: aForm at: aPoint [
	"Blit a Squeak Form into pixelBytes at aPoint, converting the Form's 32bpp ARGB
	words to our RGBA8 bytes. Transparent pixels (alpha 0) are skipped so text can be
	composited over the graph. Marks the touched rect dirty."

	self drawForm: aForm at: aPoint extent: aForm width @ aForm height
]

{
	#category : #editing,
	#'squeak_changestamp' : 'MCPServer 8/13/2026 16:31'
}
SRTextureSource >> drawForm: aForm at: aPoint extent: anExtent [
	"BitBlt the top-left anExtent sub-rectangle of aForm onto the backing Form at
	aPoint, replacing the destination (Form over). One BitBlt, done in C."

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
	#'squeak_changestamp' : 'MCPServer 8/14/2026 15:41'
}
SRTextureSource >> drawForm: aForm at: aPoint scale: anInteger [
	"Blit aForm onto the backing Form at aPoint, magnified by anInteger. Used to
	compose 1x graphs into a supersampled (2x) texture; the GPU's bilinear filter then
	minifies it back down, anti-aliasing the edges."

	| dstExtent |
	dstExtent := (aForm width * anInteger) @ (aForm height * anInteger).
	(WarpBlt toForm: form)
		sourceForm: aForm;
		colorMap: nil;
		cellSize: 2;
		combinationRule: Form over;
		copyQuad: aForm boundingBox innerCorners
		toRect: (aPoint extent: dstExtent).
	self markDirty: (aPoint extent: dstExtent)
]

{
	#category : #editing,
	#'squeak_changestamp' : 'MCPServer 8/13/2026 15:18'
}
SRTextureSource >> drawString: aString at: aPoint color: aColor [
	"Render aString to a transparent Form via BitBlt, then composite it into pixelBytes.
	Antialiased text keeps its coverage alpha, so it blends over the graph."

	| fnt w h |
	fnt := TextStyle defaultFont.
	w := (fnt widthOfString: aString) max: 1.
	h := fnt height.
	"Reuse one scratch Form; only reallocate when it must grow."
	(textForm isNil or: [textForm width < w or: [textForm height < h]]) ifTrue: [
		textForm := Form extent: w @ h depth: 32].
	textForm fillColor: Color transparent.
	textForm getCanvas drawString: aString at: 0 @ 0 font: fnt color: aColor.
	self drawForm: textForm at: aPoint extent: w @ h
]

{
	#category : #editing,
	#'squeak_changestamp' : 'MCPServer 8/13/2026 15:44'
}
SRTextureSource >> drawString: aString at: aPoint color: aColor on: bgColor [
	"Draw text onto an opaque bgColor-filled scratch Form, so BitBlt antialiases the
	glyphs against the known background and every result pixel is opaque -- no
	premultiplied-alpha compositing on our side, hence no edge rounding error. Then
	straight-copy the strip in. bgColor should match the destination region."

	self drawString: aString at: aPoint color: aColor on: bgColor font: TextStyle defaultFont
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
	#'squeak_changestamp' : 'MCPServer 8/14/2026 15:40'
}
SRTextureSource >> drawString: aString at: aPoint color: aColor on: bgColor font: aFont scale: anInteger [
	"Render the string once at native font size into a scratch Form, then blit it
	magnified by anInteger into the supersampled backing Form."

	| w h scratch |
	anInteger = 1 ifTrue: [
		^ self drawString: aString at: aPoint color: aColor on: bgColor font: aFont].
	w := (aFont widthOfString: aString) max: 1.
	h := aFont height.
	scratch := Form extent: w @ h depth: 32.
	scratch getCanvas
		fillRectangle: (0 @ 0 extent: w @ h) color: bgColor;
		drawString: aString at: 0 @ 0 font: aFont color: aColor.
	self drawForm: scratch at: aPoint scale: anInteger
]

{
	#category : #editing,
	#'squeak_changestamp' : 'MCPServer 8/13/2026 16:32'
}
SRTextureSource >> editDo: aBlock [
	"Run edits (via the draw helpers, which accumulate dirtyRect), then notify
	dependents once. Mirrors SRMeshSourceRaw>>editDo:."

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
	#'squeak_changestamp' : 'MCPServer 8/13/2026 16:31'
}
SRTextureSource >> fillColumn: x top: top bottom: bottom color: aColor [
	"Fast vertical span, the workhorse for a scrolling bar graph. top inclusive,
	bottom exclusive, clamped."

	| y0 y1 |
	(x < 0 or: [x >= width]) ifTrue: [^ self].
	y0 := top max: 0.
	y1 := bottom min: height.
	y0 >= y1 ifTrue: [^ self].
	canvas fillRectangle: (x @ y0 corner: x + 1 @ y1) color: aColor.
	self markDirty: (x @ y0 corner: x + 1 @ y1)
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
	#'squeak_changestamp' : 'MCPServer 8/13/2026 13:39'
}
SRTextureSource >> markDirty: aRectangle [
	"Grow the accumulated dirty region to include aRectangle, clamped to the texture."

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
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 8/13/2026 16:30'
}
SRTextureSource >> pixelBytes [

	"Kept for compatibility; the buffer is now the Form's bits."
	^ form bits
]

{
	#category : #editing,
	#'squeak_changestamp' : 'MCPServer 8/13/2026 16:31'
}
SRTextureSource >> scrollLeftBy: n [
	"Shift the whole image n pixels to the left, in place, row by row. The freed
	rightmost n columns are left untouched (caller redraws them). Mirrors FormGraph's
	single-blit scroll, but on the RGBA byte buffer. Marks all dirty."

	(n <= 0 or: [n >= width]) ifTrue: [^ self].
	form
		copy: (n @ 0 corner: width @ height)
		from: form
		to: 0 @ 0
		rule: Form over.
	self markAllDirty
]

{
	#category : #editing,
	#'squeak_changestamp' : 'MCPServer 8/13/2026 16:31'
}
SRTextureSource >> setPixelAt: aPoint color: aColor [

	| x y |
	x := aPoint x.
	y := aPoint y.
	(x < 0 or: [x >= width or: [y < 0 or: [y >= height]]]) ifTrue: [^ self].
	form colorAt: aPoint put: aColor.
	self markDirty: (x @ y corner: x + 1 @ (y + 1))
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
