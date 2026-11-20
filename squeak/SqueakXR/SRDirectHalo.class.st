Class {
	#name : #SRDirectHalo,
	#superclass : #SRHalo,
	#instVars : [
		'rotationGizmo'
	],
	#category : #'SqueakXR-Halo'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 11/20/2026 17:11'
}
SRDirectHalo >> addHandles [ 

	self addChild: (SRHaloButton new
		text: 'Move';
		color: Color brown;
		stepAction: [:btn | btn 
			globalTranslation: self target globalTranslation;
			faceCamera
		];
		dragAction: [:btn :xform | self target globalTranslation: xform translation]
	).
	rotationGizmo := self addChild: (SRRotationGizmo new scale: 0.5 asVector3)
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 11/18/2026 14:34'
}
SRDirectHalo >> step: deltatime [
	
	rotationGizmo isGrabbed ifTrue: [
		self target globalRotation: rotationGizmo globalRotation.
	] ifFalse: [
		rotationGizmo globalRotation: self target globalRotation.
	].
	rotationGizmo globalTranslation: self target globalTranslation.
]
