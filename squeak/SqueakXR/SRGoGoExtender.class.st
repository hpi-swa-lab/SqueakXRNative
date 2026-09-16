Class {
	#name : #SRGoGoExtender,
	#superclass : #SRObject,
	#instVars : [
		'shoulderCube'
	],
	#category : #'SqueakXR-Objects'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 9/16/2026 14:42'
}
SRGoGoExtender >> initialize [ 

	super initialize.
	
	shoulderCube := (SRCube new scale: 5cm asVector3).
	self addChild: shoulderCube.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 9/16/2026 14:48'
}
SRGoGoExtender >> step: deltaTime [ 

	| fromShoulder rr d k rv shoulder |
	shoulder := self world avatar shoulderPosition.
	fromShoulder := self parent globalTranslation - shoulder.
	rr := fromShoulder length.
	d := 0.3m.
	k := 8.
	rv := (rr < d) ifTrue: rr
		ifFalse: [
		rr + (k * ((rr - d) ** 2))
	].
	self globalTranslation: shoulder + (fromShoulder normalized * rv).
	shoulderCube globalTranslation: shoulder.
]
