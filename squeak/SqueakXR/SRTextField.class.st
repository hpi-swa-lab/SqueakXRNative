Class {
	#name : #SRTextField,
	#superclass : #SRObject,
	#instVars : [
		'textPanel',
		'text',
		'color'
	],
	#category : #'SqueakXR-Objects'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 11/3/2026 14:06'
}
SRTextField class >> fontFor: aSRRenderer [

	SRRenderer assertContext.
	^ aSRRenderer cacheAt: #TextFieldFont ifAbsentPut: [ | font |
		font := Raylib loadFontFileName: (
			(SRAssets assetsDirectory / 'fonts' / 'dejavu-fonts-ttf-2.37' / 'ttf' / 'DejaVuSans.ttf') pathString).
		(Raylib isFontValidFont: font)
			ifTrue: [font]
			ifFalse: [self error: 'Failed to load font'. nil]]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 4/2/2026 13:32'
}
SRTextField >> color [

	^ color
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 4/2/2026 13:32'
}
SRTextField >> color: aColor [

	color := aColor
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'lege 4/2/2026 13:32'
}
SRTextField >> initialize [

	super initialize.
	
	self text: 'text';
		color: Color black
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'leo 11/3/2026 13:45'
}
SRTextField >> renderOn: aSRRenderer [

	aSRRenderer renderString: self text transformed: self globalTransform color: self color font: (self class fontFor: aSRRenderer)
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 4/2/2026 13:06'
}
SRTextField >> text [

	^ text
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 4/2/2026 13:05'
}
SRTextField >> text: aString [

	text := aString
]
