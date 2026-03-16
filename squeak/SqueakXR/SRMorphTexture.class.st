Class {
	#name : #SRMorphTexture,
	#superclass : #Object,
	#instVars : [
		'morph',
		'texture',
		'extent',
		'update',
		'updateRects'
	],
	#category : #'SqueakXR-Morphic'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 3/11/2026 16:37'
}
SRMorphTexture class >> shader [

	^ SRShader morphicPanel
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 3/11/2026 17:22'
}
SRMorphTexture >> createTexture [

	| form |
	form := self morph imageForm.
	self extent: form extent.
	^ texture := form createTexture
]

{ #category : #'as yet unclassified' }
SRMorphTexture >> extent [

	^ extent
]

{ #category : #'as yet unclassified' }
SRMorphTexture >> extent: aPoint [

	extent := aPoint
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 2/23/2026 11:38'
}
SRMorphTexture >> fullUpdate [

	update := #full
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 2/23/2026 11:39'
}
SRMorphTexture >> initialize [

	updateRects := OrderedCollection new.
]

{ #category : #'as yet unclassified' }
SRMorphTexture >> morph [

	^ morph
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 3/16/2026 17:28'
}
SRMorphTexture >> morph: aMorph [
	
	morph ifNotNil: [morph removeDependent: self].
	
	morph := aMorph.
	morph ifNotNil: [morph addDependent: self].
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 3/6/2026 12:06'
}
SRMorphTexture >> partialUpdate: aRectangle [

	update = #full ifTrue: [^ self].
	
	update := #partial.
	updateRects add: aRectangle.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 3/16/2026 17:27'
}
SRMorphTexture >> removeMorph [

	self morph: nil
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 3/11/2026 16:38'
}
SRMorphTexture >> resetTexture [

	texture := nil.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 3/11/2026 17:06'
}
SRMorphTexture >> shader [

	^ XRWorld cacheAt: #morphTextureShader ifAbsentPut: [self class shader load]
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 3/6/2026 12:03'
}
SRMorphTexture >> update [

	^ (texture isNil or: [self extent ~= self morph extent])
		ifTrue: [self createTexture]
		ifFalse: [self updateTexture]
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 3/11/2026 18:04'
}
SRMorphTexture >> update: aSymbol with: anObject [

	aSymbol = #worldDrawn ifTrue: [
		self partialUpdate: anObject]
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 3/16/2026 17:29'
}
SRMorphTexture >> updateTexture [

	| updateRect |
	(update isNil or: [morph isNil]) ifTrue: [^ texture].
	
	update := #full. "seems fast enough for now"
	updateRect := update caseOf: {
		[#full] -> [self morph bounds].
		[#partial] -> [Rectangle merging: updateRects]}.
	
	(self morph imageFormForRectangle: updateRect)
		updateTexture: texture
		in: (updateRect relativeTo: self morph bounds).
	
	updateRects removeAll.
	update := nil.
	
	^ texture
]
