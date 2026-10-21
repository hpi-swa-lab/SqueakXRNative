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
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 15:01'
}
SRTextureSourceTest >> testBitsAreUsableAfterTheFormIsHibernated [
	"Saving the image compresses a Form Bitmap into a ByteArray."
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
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 15:00'
}
SRTextureSourceTest >> testUnhibernatingMarksTheTextureDirty [

	source fillColor: Color red.
	source clearDirty.
	self assert: source dirtyRect isNil.
	source form hibernate.
	source bits.
	self deny: source dirtyRect isNil.
]
