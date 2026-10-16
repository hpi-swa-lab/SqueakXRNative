"
Tests for the CPU side of a texture, in particular that it survives an image save.
"
Class {
	#name : #SRTextureSourceTest,
	#superclass : #TestCase,
	#instVars : [
		'source'
	],
	#category : #'SqueakXR-Tests-Core',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #running,
	#'squeak_changestamp' : 'MCPServer 10/15/2026 15:53'
}
SRTextureSourceTest >> setUp [
	super setUp.
	source := SRTextureSource new setWidth: 32 height: 32.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer 10/15/2026 15:53'
}
SRTextureSourceTest >> testBitsAreUsableAfterTheFormIsHibernated [
	"Saving the image compresses a Form's Bitmap into a ByteArray. Uploading
	that to the GPU would send a few hundred compressed bytes as if they were
	pixels, and writing into it raises an improper store."

	| expected |
	expected := source width * source height.
	source fillColor: Color red.
	source form hibernate.
	self assert: source form bits class equals: ByteArray.
	self assert: source bits class equals: Bitmap.
	self assert: source bits size equals: expected.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer 10/15/2026 15:53'
}
SRTextureSourceTest >> testUnhibernatingMarksTheTextureDirty [
	"Whatever the GPU holds predates the save, so the whole buffer has to go up
	again rather than waiting for a pixel to change."

	source fillColor: Color red.
	source clearDirty.
	self assert: source dirtyRect isNil.
	source form hibernate.
	source bits.
	self deny: source dirtyRect isNil.
]
