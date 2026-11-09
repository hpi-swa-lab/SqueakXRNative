Class {
	#name : #SRTextField,
	#superclass : #SRObject,
	#instVars : [
		'textPanel',
		'text',
		'color',
		'billboard'
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
	#category : #constants,
	#'squeak_changestamp' : 'MCPServer (leo) 11/9/2026 13:33'
}
SRTextField class >> uprightRotation [

	^ Quaternion new radiansAngle: Float pi / 2 axis: Vector3 right
]

{
	#category : #layout,
	#'squeak_changestamp' : 'MCPServer (leo) 11/9/2026 13:39'
}
SRTextField >> alignLeftIn: aBoxSize inset: aNumber [

	self position: (aBoxSize x / -2 + aNumber) @ (self textHeight * self scale y / 2) @ (aBoxSize z / 2 + 1mm)
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
	#category : #transforming,
	#'squeak_changestamp' : 'MCPServer (leo) 11/9/2026 13:45'
}
SRTextField >> face: aGlobalVector3 [

	super face: aGlobalVector3.
	self rotation: self class uprightRotation * self rotation
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'MCPServer (leo) 11/9/2026 13:39'
}
SRTextField >> initialize [

	super initialize.
	
	self text: 'text';
		color: Color black;
		billboard: false
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
	#'squeak_changestamp' : 'MCPServer (leo) 11/9/2026 13:45'
}
SRTextField >> step: deltaTime [

	self billboard ifTrue: [self faceCamera].
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
