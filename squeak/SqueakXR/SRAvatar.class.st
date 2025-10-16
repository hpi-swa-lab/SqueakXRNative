Class {
	#name : #SRAvatar,
	#superclass : #SRObject,
	#instVars : [
		'camera',
		'leftHand',
		'rightHand'
	],
	#category : #'SqueakXR-Objects'
}

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 10/8/2025 17:49'
}
SRAvatar >> camera [

	^ camera
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/8/2025 17:57'
}
SRAvatar >> cameraPosition: position target: target up: up [

	camera localTranslation: position
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'lege 10/8/2025 17:49'
}
SRAvatar >> initialize [

	super initialize.
	
	leftHand := SRHand left.
	rightHand := SRHand right.
	camera := SRObject new name: 'Camera'.

	self addChild: leftHand;
		addChild: rightHand;
		addChild: camera.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 10/8/2025 17:50'
}
SRAvatar >> leftHand [

	^ leftHand
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 10/8/2025 17:50'
}
SRAvatar >> rightHand [

	^ rightHand
]
