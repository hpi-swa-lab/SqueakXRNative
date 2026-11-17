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
	#'squeak_changestamp' : 'phkeese 11/17/2026 14:53'
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
	rotationGizmo := SRRotationGizmo new
		target: self target.
	self addChild: rotationGizmo.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 11/17/2026 14:54'
}
SRDirectHalo >> step: deltatime [

	rotationGizmo globalTranslation: self target globalTranslation
]
