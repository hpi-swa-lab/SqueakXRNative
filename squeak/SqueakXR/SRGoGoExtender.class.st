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
	#'squeak_changestamp' : 'MCPServer (jl) 11/10/2026 18:36'
}
SRGoGoExtender >> initialize [ 

	super initialize.
	
	shoulderCube := SRCube new
		scale: 5cm asVector3;
		ignoreCollision: true;
		yourself.
	self addChild: shoulderCube.
]

{
	#category : #updating,
	#'squeak_changestamp' : 'MCPServer (jl) 11/10/2026 18:30'
}
SRGoGoExtender >> placeAt: aPoint [
	"#globalTranslation: would keep the rotation of the previous frame, and the ray with it."

	self globalTransform: (self parent globalTransform copy
		translation: aPoint;
		yourself).
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 9/29/2026 15:09'
}
SRGoGoExtender >> step: deltaTime [ 

	self updatePosition
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'jl-MCPServer 11/20/2026 13:48'
}
SRGoGoExtender >> updatePosition [

	| fromShoulder rr d k rv shoulder avatar |
	avatar := self parent hand avatar.
	shoulderCube visible: ((avatar notNil and: [avatar isControllerDriven]) and: [self parent isDirect not]).
	shoulderCube visible ifFalse: [
		"The simulator reaches with the mouse, a held tool reaches only as far as the hand."
		^ self placeAt: self parent globalTranslation].
	shoulder := avatar shoulderPosition.
	fromShoulder := self parent globalTranslation - shoulder.
	rr := fromShoulder length.
	d := 0.3m.
	k := 8.
	rv := (rr < d) ifTrue: rr
		ifFalse: [
		rr + (k * ((rr - d) ** 2))	].
	self placeAt: shoulder + (fromShoulder normalized * rv).
	shoulderCube globalTranslation: shoulder.
]
