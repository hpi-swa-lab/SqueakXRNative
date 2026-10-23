"
Tests for the CPU side of a texture, in particular that it survives an image save.
"
Class {
	#name : #SRTextureSourceFormTest,
	#superclass : #TestCase,
	#instVars : [
		'source',
		'changes'
	],
	#category : #'SqueakXR-Tests-Core',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #running,
	#'squeak_changestamp' : 'MCPServer (MCPServer (MCPServer)) 10/23/2026 11:01'
}
SRTextureSourceFormTest >> setUp [

	super setUp.
	source := SRTextureSourceForm width: 32 height: 32 fill: Color red.
	changes := OrderedCollection new.
	source addDependent: self.
]

{
	#category : #running,
	#'squeak_changestamp' : 'MCPServer (MCPServer (MCPServer)) 10/23/2026 11:01'
}
SRTextureSourceFormTest >> tearDown [

	source removeDependent: self.
	super tearDown.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (MCPServer (MCPServer)) 10/23/2026 11:01'
}
SRTextureSourceFormTest >> testBitsAreUsableAfterTheFormIsHibernated [
	"Saving the image compresses a Form Bitmap into a ByteArray."
	source form hibernate.
	self assert: source form bits class equals: ByteArray.
	self assert: source bits class equals: Bitmap.
	self assert: source bits size equals: source width * source height.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (MCPServer (MCPServer)) 10/23/2026 11:01'
}
SRTextureSourceFormTest >> testDrawingOutsideEditDoIsRefused [

	self should: [source fillColor: Color blue] raise: AssertionFailure.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (MCPServer (MCPServer)) 10/23/2026 11:01'
}
SRTextureSourceFormTest >> testEditDoNotifiesOnce [

	source editDo: [:each |
		each fillColor: Color blue.
		each fillRect: (0 @ 0 extent: 4 @ 4) color: Color green].
	self assert: (changes select: [:each | each == #textureChanged]) size equals: 1.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (MCPServer (MCPServer)) 10/23/2026 11:01'
}
SRTextureSourceFormTest >> testReadingBitsOfALiveFormDoesNotNotify [
	"A notification drops the GPU texture, so one per read would re-upload every frame."
	source bits.
	self assert: changes isEmpty.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (MCPServer (MCPServer)) 10/23/2026 11:01'
}
SRTextureSourceFormTest >> testUnhibernatingNotifiesTextureChanged [

	source form hibernate.
	source bits.
	self assert: (changes includes: #textureChanged).
]

{
	#category : #updating,
	#'squeak_changestamp' : 'MCPServer (MCPServer (MCPServer)) 10/23/2026 11:01'
}
SRTextureSourceFormTest >> update: aParameter [

	changes add: aParameter.
]
