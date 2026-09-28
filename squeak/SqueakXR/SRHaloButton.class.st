Class {
	#name : #SRHaloButton,
	#superclass : #SRObject,
	#instVars : [
		'text',
		'cube'
	],
	#category : #'SqueakXR-Halo'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 9/28/2026 16:08'
}
SRHaloButton >> color [
	^cube color
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 9/28/2026 16:08'
}
SRHaloButton >> color: aColor [
	cube color: aColor
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 9/28/2026 16:13'
}
SRHaloButton >> initialize [ 

	super initialize.
	
	text := SRTextField new
		scale: 0.03 asVector3;
		rotation: (Quaternion new radiansAngle: Float pi / 2 axis: Vector3 right);
		localTranslation: Vector3 forward * 6cm.
	self addChild: text.
	
	cube := SRCube new
		scale: 10cm asVector3.
	self addChild: cube.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 9/28/2026 16:44'
}
SRHaloButton >> step: deltaTime [ 

	| width offset |
	width := text textWidth.
	offset := width/2 negated.
	cube scale: width * 1.1@(10cm)@(10cm).
	text localTranslation: offset@0@6cm
	
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 9/28/2026 16:08'
}
SRHaloButton >> text [
	^text text
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 9/28/2026 16:13'
}
SRHaloButton >> text: aString [
	text text: aString
]
