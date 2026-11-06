Class {
	#name : #SRTextField,
	#superclass : #SRObject,
	#instVars : [
		'textPanel',
		'text',
		'color',
		'billboard',
		'centered'
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
	#'squeak_changestamp' : 'phkeese 10/1/2026 14:03'
}
SRTextField >> billboard [
	^ billboard
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/1/2026 15:52'
}
SRTextField >> billboard: aBool [
	billboard := aBool
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/15/2026 16:24'
}
SRTextField >> centered [
	^ centered
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/15/2026 16:24'
}
SRTextField >> centered: anObject [
	centered := anObject
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
	#'squeak_changestamp' : 'phkeese 10/15/2026 16:24'
}
SRTextField >> initialize [

	super initialize.
	
	self text: 'text';
		color: Color black;
		billboard: false;
		centered: false
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'leo 11/3/2026 13:45'
}
SRTextField >> renderOn: aSRRenderer [

	aSRRenderer renderString: self text transformed: self globalTransform color: self color font: (self class fontFor: aSRRenderer)
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'phkeese 10/1/2026 15:48'
}
SRTextField >> step: deltaTime [

	self billboard ifTrue: [ | scale target |
		scale := Matrix4x4 identity scaledBy: self globalScale.
		target := self world camera globalTranslation.
		self globalTransform: ((Matrix4x4
			objectLookAt: target from: self 				 globalTranslation up: Vector3 up) * scale).
	].
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

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/15/2026 16:54'
}
SRTextField >> textHeight [

	^ 1.1
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/15/2026 16:54'
}
SRTextField >> textSize [

	^ (self textWidth)@(self textHeight)
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/15/2026 16:47'
}
SRTextField >> textWidth [

	"Best-effort estimate of our text size in parent-local space."
	^ self text size * 0.8
]
