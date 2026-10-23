"
A texture source that renders a Morph. Squeak Forms are BGRA, so draw with the morphicPanel shader.
"
Class {
	#name : #SRTextureSourceMorph,
	#superclass : #SRTextureSource,
	#instVars : [
		'morph',
		'canvas',
		'internalTexture'
	],
	#category : #'SqueakXR-Morphic',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'MCPServer (leo) 10/15/2026 11:09'
}
SRTextureSourceMorph class >> on: aMorph [

	^ self new morph: aMorph; yourself
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer (leo) 10/15/2026 11:09'
}
SRTextureSourceMorph >> createInternalTexture [

	| form |
	SRRenderer assertContext.
	form := self drawMorph.
	(internalTexture notNil and: [internalTexture width @ internalTexture height = form extent])
		ifTrue: [form updateTexture: internalTexture in: (0 @ 0 extent: form extent)]
		ifFalse: [
			internalTexture ifNotNil: [Raylib unloadTexture: internalTexture].
			internalTexture := form createTexture].
	^ internalTexture
]

{
	#category : #private,
	#'squeak_changestamp' : 'MCPServer (leo) 10/15/2026 12:49'
}
SRTextureSourceMorph >> drawMorph [

	morph ifNil: [^ canvas form].
	morph extent = canvas extent
		ifFalse: [canvas setForm: (Form extent: morph extent depth: canvas depth)].
	canvas translateBy: morph topLeft negated during: [:tempCanvas | tempCanvas fullDrawMorph: morph].
	^ canvas form
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'MCPServer (leo) 10/15/2026 11:09'
}
SRTextureSourceMorph >> initialize [

	super initialize.
	canvas := Display defaultCanvasClass extent: 100 @ 100 depth: 32.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer (leo) 10/15/2026 11:09'
}
SRTextureSourceMorph >> morph [

	^ morph
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer (leo) 10/15/2026 11:09'
}
SRTextureSourceMorph >> morph: aMorph [

	morph ifNotNil: [morph removeDependent: self].
	morph := aMorph.
	morph ifNotNil: [morph addDependent: self].
	self notifyTextureChanged.
]

{
	#category : #updating,
	#'squeak_changestamp' : 'MCPServer (leo) 10/15/2026 11:09'
}
SRTextureSourceMorph >> onCacheInvalidated [

	internalTexture := nil.
]

{
	#category : #updating,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/23/2026 12:28'
}
SRTextureSourceMorph >> unload [

	SRRenderer hasContext ifTrue: [
		internalTexture ifNotNil: [Raylib unloadTexture: internalTexture]].
	internalTexture := nil.
]

{
	#category : #updating,
	#'squeak_changestamp' : 'MCPServer (leo) 10/15/2026 11:09'
}
SRTextureSourceMorph >> update: aSymbol with: anObject [

	aSymbol = #worldDrawn ifTrue: [self notifyTextureChanged].
]
