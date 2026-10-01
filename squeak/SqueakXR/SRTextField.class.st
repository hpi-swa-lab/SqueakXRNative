Class {
	#name : #SRTextField,
	#superclass : #SRObject,
	#instVars : [
		'textPanel',
		'text',
		'color',
		'billboard',
		'overlay'
	],
	#category : #'SqueakXR-Objects'
}

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
	#category : #initialization,
	#'squeak_changestamp' : 'phkeese 10/1/2026 14:08'
}
SRTextField >> initialize [

	super initialize.
	
	self text: 'text';
		color: Color black;
		billboard: false;
		overlay: false
		
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/1/2026 14:08'
}
SRTextField >> overlay [
	^ overlay
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/1/2026 15:52'
}
SRTextField >> overlay: aBool [
	overlay := aBool
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'phkeese 10/1/2026 14:08'
}
SRTextField >> renderInSecondPass [ 
	^overlay
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'phkeese 10/1/2026 15:47'
}
SRTextField >> renderOn: aSRRenderer [

	| faceForward xform |
	faceForward := (Quaternion new radiansAngle: Float pi / 2 axis:  Vector3 right) asMatrix4x4.
	xform := self globalTransform * faceForward.
	aSRRenderer renderString: self text transformed: xform color: self color
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
	#'squeak_changestamp' : 'phkeese 9/28/2026 16:51'
}
SRTextField >> textWidth [

	"Best-effort estimate of our text size in parent-local space."
	^ (Raylib measureText: self text fontSize: self scale x) * 0.003
]
